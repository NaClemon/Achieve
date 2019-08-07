package com.example.prac2;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;

import org.tensorflow.lite.DataType;
import org.tensorflow.lite.Tensor;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.PriorityQueue;

public class DrawOn extends View {

    final private static double threshold = 0.7;
    final private static double imgMean = 125.0;
    final private static double imgStd= 125.0;
    final private static int numResults = 2;
    final private static int nmsRadius = 10;
    final private static int outputStride = 1;

    private static String[] partNames = {
            "nose", "leftEye", "rightEye", "leftEar", "rightEar", "leftShoulder",
            "rightShoulder", "leftElbow", "rightElbow", "leftWrist", "rightWrist",
            "leftHip", "rightHip", "leftKnee", "rightKnee", "leftAnkle", "rightAnkle"
    };

    private static String[][] poseChain = {
            {"nose", "leftEye"}, {"leftEye", "leftEar"}, {"nose", "rightEye"},
            {"rightEye", "rightEar"}, {"nose", "leftShoulder"},
            {"leftShoulder", "leftElbow"}, {"leftElbow", "leftWrist"},
            {"leftShoulder", "leftHip"}, {"leftHip", "leftKnee"},
            {"leftKnee", "leftAnkle"}, {"nose", "rightShoulder"},
            {"rightShoulder", "rightElbow"}, {"rightElbow", "rightWrist"},
            {"rightShoulder", "rightHip"}, {"rightHip", "rightKnee"},
            {"rightKnee", "rightAnkle"}
    };

    private Map<String, Integer> partsIds = new HashMap<>();
    private List<Integer> parentToChildEdges = new ArrayList<>();
    private List<Integer> childToParentEdges = new ArrayList<>();

    private ByteBuffer imgData;
    private Map<Integer, Object> outputMap;

    private static int inputSize;

    public int cnt = 0;
    public Canvas canvas;

    public DrawOn(Context context) {
        super(context);

        try {
            MainActivity temp = new MainActivity();
            imgData = feedInputTensor("./", (float)imgMean, (float)imgStd);
            Object[] input = new Object[]{imgData};
            outputMap = new HashMap<>();

            for (int i = 0; i < temp.getTfLite().getOutputTensorCount(); i++) {
                int[] shape = temp.getTfLite().getOutputTensor(i).shape();
                float[][][][] output = new float[shape[0]][shape[1]][shape[2]][shape[3]];
                outputMap.put(i, output);
            }

            temp.getTfLite().runForMultipleInputsOutputs(input, outputMap);


            decodePose();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        this.canvas = canvas;

        Paint pt = new Paint();
        pt.setColor(Color.GREEN);
        pt.setStrokeWidth(5);

        canvas.drawLine(100, 350, 100, 400, pt);
        canvas.drawLine(100, 350, 200, 350, pt);
    }

    // Feeding an Image to Input Tensor
    ByteBuffer feedInputTensor(String path, float mean, float std) throws IOException {
        MainActivity mainActivity = new MainActivity();
        CameraPreview cameraPreview = (CameraPreview) findViewById(R.id.preview);

        Bitmap bitmapRaw = cameraPreview.getBitmap();

//        InputStream inputStream = new FileInputStream(path.replace("file://", ""));
//        Bitmap bitmapRaw = BitmapFactory.decodeStream(inputStream);

        Tensor tensor = mainActivity.getTfLite().getInputTensor(0);

        int[] shape = tensor.shape();
        inputSize = shape[1];
        int inputChannels = shape[3];

        ByteBuffer imgData = ByteBuffer.allocateDirect(1 * inputSize * inputSize * inputChannels * 4);
        imgData.order(ByteOrder.nativeOrder());

        Bitmap bitmap = bitmapRaw;
        if (bitmapRaw.getWidth() != inputSize || bitmapRaw.getHeight() != inputSize) {
            Matrix matrix = getTransformationMatrix(bitmapRaw.getWidth(), bitmapRaw.getHeight(),
                    inputSize, inputSize, false);
            bitmap = Bitmap.createBitmap(inputSize, inputSize, Bitmap.Config.ARGB_8888);
            final Canvas canvas = new Canvas(bitmap);
            canvas.drawBitmap(bitmapRaw, matrix, null);
        }

        if (tensor.dataType() == DataType.FLOAT32) {
            for (int i = 0; i < inputSize; ++i)
                for (int j = 0; j < inputSize; ++j) {
                    int pixelValue = bitmap.getPixel(j, i);
                    imgData.putFloat((((pixelValue >> 16) & 0xFF) - mean) / std);
                    imgData.putFloat((((pixelValue >> 8) & 0xFF) - mean) / std);
                    imgData.putFloat(((pixelValue & 0xFF) - mean) / std);
                }
        }
        else {
            for (int i = 0; i < inputSize; ++i)
                for (int j = 0; j < inputSize; ++j) {
                    int pixelValue = bitmap.getPixel(j, i);
                    imgData.putFloat((byte)((pixelValue >> 16) & 0xFF));
                    imgData.putFloat((byte)((pixelValue >> 8) & 0xFF));
                    imgData.putFloat((byte)(pixelValue & 0xFF));
                }
        }
        return imgData;
    }

    private static Matrix getTransformationMatrix(final int srcWidth,
                                                  final int srcHeight,
                                                  final int dstWidth,
                                                  final int dstHeight,
                                                  final boolean maintainAspectRatio) {
        final Matrix matrix = new Matrix();

        if (srcWidth != dstWidth || srcHeight != dstHeight) {
            final float scaleFactorX = (float) dstWidth / srcWidth;
            final float scaleFactorY = (float) dstHeight / srcHeight;

            if (maintainAspectRatio) {
                final float scaleFactor = Math.max(scaleFactorX, scaleFactorY);
                matrix.postScale(scaleFactor, scaleFactor);
            } else {
                matrix.postScale(scaleFactorX, scaleFactorY);
            }
        }
        matrix.invert(new Matrix());
        return matrix;
    }

    private void decodePose() {
        for (int i = 0; i < partNames.length; i++)
            partsIds.put(partNames[i], i);

        for (int i = 0; i < poseChain.length; i++) {
            childToParentEdges.add(partsIds.get(poseChain[i][0]));
            parentToChildEdges.add(partsIds.get(poseChain[i][1]));
        }

        float[][][] scores = ((float[][][][])outputMap.get(0))[0];
        float[][][] offsets = ((float[][][][])outputMap.get(1))[0];
        float[][][] displacementsFwd = ((float[][][][])outputMap.get(2))[0];
        float[][][] displacementsBwd = ((float[][][][])outputMap.get(3))[0];

        PriorityQueue<Map<String, Object>> pq = buildPartWithScoreQueue(scores, threshold, nmsRadius);

        int numParts = scores[0][0].length;
        int numEdges = parentToChildEdges.size();
        int sqardNmsRadius = nmsRadius * nmsRadius;

        List<Map<String, Object>> results = new ArrayList<>();

        while (results.size() < numResults && pq.size() > 0) {
            Map<String, Object> root = pq.poll();
            float[] rootPoint = getImageCoords(root, outputStride, numParts, offsets);

            if (withinNmsRadiusOfCorrespondingPoint(results, sqardNmsRadius, rootPoint[0],
                    rootPoint[1], (int)root.get("partId")))
                continue;

            Map<String, Object> keypoint = new HashMap<>();
            keypoint.put("score", root.get("score"));
            keypoint.put("part", partNames[(int)root.get("partId")]);
            keypoint.put("y", rootPoint[0] / inputSize);
            keypoint.put("x", rootPoint[1] / inputSize);

            Map<Integer, Map<String, Object>>keypoints = new HashMap<>();
            keypoints.put((int)root.get("partId"), keypoint);

            for (int edge = numEdges -1; edge >= 0; edge--) {
                int sourceKeypointId = parentToChildEdges.get(edge);
                int targetKeypointId = childToParentEdges.get(edge);

                if (keypoints.containsKey(sourceKeypointId) && !keypoints.containsKey(targetKeypointId)) {
                    keypoint = traversToTargetKeypoint(edge, keypoints.get(sourceKeypointId),
                            targetKeypointId, scores, offsets, outputStride, displacementsBwd);
                    keypoints.put(targetKeypointId, keypoint);
                }
            }

            for (int edge = 0; edge < numEdges; edge++) {
                int sourceKeypointId = childToParentEdges.get(edge);
                int targetKeypointId = parentToChildEdges.get(edge);

                if (keypoints.containsKey(sourceKeypointId) && !keypoints.containsKey(targetKeypointId)) {
                    keypoint = traversToTargetKeypoint(edge, keypoints.get(sourceKeypointId),
                            targetKeypointId, scores, offsets, outputStride, displacementsFwd);
                    keypoints.put(targetKeypointId, keypoint);
                }
            }

            Map<String, Object> result = new HashMap<>();
            result.put("keypoints", keypoints);
            result.put("score", getInstanceScore(keypoints, numParts));
            results.add(result);

            Log.d("결과 확인", keypoints.toString());
        }
    }

    boolean withinNmsRadiusOfCorrespondingPoint(List<Map<String, Object>> poses,
                                                float squaredNmsRadius, float y,
                                                float x, int keypointId) {
        for (Map<String, Object> pose : poses) {
            Map<Integer, Object> keypoints = (Map<Integer, Object>)pose.get("keypoints");
            Map<String, Object> correspondingKeypoint = (Map<String, Object>)keypoints.get(keypointId);

            float _x = (float)correspondingKeypoint.get("x") * inputSize - x;
            float _y = (float)correspondingKeypoint.get("y") * inputSize - y;
            float squaredDistance = _x * _x + _y * _y;

            if (squaredDistance <= squaredNmsRadius)
                return true;
        }
        return false;
    }

    float[] getImageCoords(Map<String, Object> keypoint, int outputStride, int numParts,
                           float[][][] offsets) {
        int heatmapY = (int)keypoint.get("y");
        int heatmapX = (int)keypoint.get("x");
        int keypointId = (int)keypoint.get("partId");
        float offsetY = offsets[heatmapY][heatmapX][keypointId];
        float offsetX = offsets[heatmapY][heatmapX][keypointId + numParts];

        float y = heatmapY * outputStride + offsetY;
        float x = heatmapX * outputStride + offsetX;

        return new float[]{y, x};
    }

    PriorityQueue<Map<String, Object>> buildPartWithScoreQueue(float[][][] scores,
                                                               double threshold,
                                                               int localMaximumRadius) {
        PriorityQueue<Map<String, Object>> pq = new PriorityQueue<>(1,
                new Comparator<Map<String, Object>>() {
                    @Override
                    public int compare(Map<String, Object> o1, Map<String, Object> o2) {
                        return Float.compare((float)o2.get("score"), (float)o1.get("score"));
                    }
                });

        for (int heatmapY = 0; heatmapY < scores.length; heatmapY++) {
            for (int heatmapX = 0; heatmapX < scores[0].length; heatmapX++) {
                for (int keypointId = 0; keypointId < scores[0][0].length; keypointId++) {
                    float score = sigmoid(scores[heatmapY][heatmapX][keypointId]);
                    if (score < threshold)
                        continue;

                    if (scoreIsMaximumInLocalWindow(keypointId, score, heatmapY,
                            heatmapX, localMaximumRadius, scores)) {
                        Map<String, Object> res = new HashMap<>();
                        res.put("score", score);
                        res.put("y", heatmapY);
                        res.put("x", heatmapX);
                        res.put("partId", keypointId);
                        pq.add(res);
                    }
                }
            }
        }
        return pq;
    }

    Map<String, Object> traversToTargetKeypoint(int edgeId, Map<String, Object> sourceKeypoint,
                                                int targetKeypointId, float[][][] scores,
                                                float[][][] offsets, int outputStride,
                                                float[][][]displacements) {
        int height = scores.length;
        int width = scores[0].length;
        int numKeypoints = scores[0][0].length;
        float sourceKeypointY = (float)sourceKeypoint.get("y") * inputSize;
        float sourceKeypointX = (float)sourceKeypoint.get("x") * inputSize;

        int[] sourceKeypointIndices = getStridedIndexNearPoint(sourceKeypointY, sourceKeypointX,
                outputStride, height, width);

        float[] displacement = getDisplacement(edgeId, sourceKeypointIndices, displacements);

        float[] displacePoint = new float[]{sourceKeypointY + displacement[0], sourceKeypointX + displacement[1]};

        float[] targetKeypoint = displacePoint;

        final int offsetRefineStep = 2;
        for (int i = 0; i < offsetRefineStep; i++) {
            int[] targetKeypointIndices = getStridedIndexNearPoint(targetKeypoint[0], targetKeypoint[1],
                    outputStride, height, width);

            int targetKeypointY = targetKeypointIndices[0];
            int targetKeypointX = targetKeypointIndices[1];

            float offsetY = offsets[targetKeypointY][targetKeypointX][targetKeypointId];
            float offsetX = offsets[targetKeypointY][targetKeypointX][targetKeypointId + numKeypoints];

            targetKeypoint = new float[]{targetKeypointY * outputStride + offsetY, targetKeypointX * outputStride + offsetX};
        }

        int[] targetKeypointIndices = getStridedIndexNearPoint(targetKeypoint[0], targetKeypoint[1], outputStride, height, width);

        float score = sigmoid(scores[targetKeypointIndices[0]][targetKeypointIndices[1]][targetKeypointId]);

        Map<String, Object> keypoint = new HashMap<>();
        keypoint.put("score", score);
        keypoint.put("part", partNames[targetKeypointId]);
        keypoint.put("y", targetKeypoint[0] / inputSize);
        keypoint.put("x", targetKeypoint[1] / inputSize);

        return keypoint;
    }

    boolean scoreIsMaximumInLocalWindow(int keypointId, float score, int heatmapY,
                                        int heatmapX, int localMaximumRadius, float[][][] scores) {
        boolean localMaximum = true;
        int height = scores.length;
        int width = scores[0].length;

        int yStart = Math.max(heatmapY - localMaximumRadius, 0);
        int yEnd = Math.min(heatmapY + localMaximumRadius + 1, height);

        for (int yCurrent = yStart; yCurrent < yEnd; yCurrent++) {
            int xStart = Math.max(heatmapX - localMaximumRadius, 0);
            int xEnd = Math.min(heatmapX + localMaximumRadius + 1, width);

            for (int xCurrent = xStart; xCurrent < xEnd; xCurrent++) {
                if (sigmoid(scores[yCurrent][xCurrent][keypointId]) > score) {
                    localMaximum = false;
                    break;
                }
            }
            if (!localMaximum)
                break;
        }

        return localMaximum;
    }

    int[] getStridedIndexNearPoint(float _y, float _x, int outputStride, int height, int width) {
        int y_ = Math.round(_y / outputStride);
        int x_ = Math.round(_x / outputStride);

        int y = y_ < 0 ? 0 : y_ > height - 1 ? height - 1 : y_;
        int x = x_ < 0 ? 0 : x_ > width - 1 ? width - 1 : x_;

        return new int[]{y, x};
    }

    float[] getDisplacement(int edgeId, int[] keypoint, float[][][] displacements) {
        int numEdges = displacements[0][0].length / 2;
        int y = keypoint[0];
        int x = keypoint[1];

        return new float[]{displacements[y][x][edgeId], displacements[y][x][edgeId + numEdges]};
    }

    float getInstanceScore(Map<Integer, Map<String, Object>> keypoints, int numKeypoints) {
        float scores = 0;
        for (Map.Entry<Integer, Map<String, Object>> keypoint : keypoints.entrySet())
            scores += (float)keypoint.getValue().get("score");

        return scores / numKeypoints;
    }

    private float sigmoid(final float x) {
        return (float) (1. / (1. + Math.exp(-x)));
    }
}
