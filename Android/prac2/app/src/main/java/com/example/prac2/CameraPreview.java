package com.example.prac2;

import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.YuvImage;
import android.util.AttributeSet;
import android.util.Log;
import android.view.Surface;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.hardware.Camera;
import android.view.View;
import android.view.ViewManager;
import android.view.WindowManager;

import java.io.ByteArrayOutputStream;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class CameraPreview extends SurfaceView implements SurfaceHolder.Callback {

    private Camera mCamera;
    public List<Camera.Size> listPreviewSizes;
    private Context context;
    private Camera.Size previewSize;
    private Bitmap bitmap;
    public int cnt = 0;
    public int i = 0;
    private static DrawOn drawOn;
    private static MainActivity mainActivity;

    public CameraPreview(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        mCamera = MainActivity.getCamera();

        if (mCamera == null) {
            mCamera = Camera.open();
        }
        listPreviewSizes = mCamera.getParameters().getSupportedPreviewSizes();

    }

    public void setMainActivity(MainActivity mainActivity) {
        this.mainActivity = mainActivity;
    }

    public void setDrawOn(DrawOn drawOn) {
        this.drawOn = drawOn;
    }

    public Bitmap getBitmap() {
        return bitmap;
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        final int width = resolveSize(getSuggestedMinimumWidth(), widthMeasureSpec);
        final int height = resolveSize(getSuggestedMinimumHeight(), heightMeasureSpec);
        setMeasuredDimension(width, height);

        mCamera.setPreviewCallback(new Camera.PreviewCallback() {

            @Override
            public void onPreviewFrame(byte[] data, Camera camera) {
                Camera.Parameters parameters = mCamera.getParameters();

                int w = parameters.getPreviewSize().width;
                int h = parameters.getPreviewSize().height;
                int format = parameters.getPreviewFormat();
                YuvImage yuvImage = new YuvImage(data, format, w, h, null);

//                Log.i("Check", "count: " + cnt);

                ByteArrayOutputStream out = new ByteArrayOutputStream();
                Rect area = new Rect(0, 0, w, h);
                yuvImage.compressToJpeg(area, 50, out);
                bitmap = BitmapFactory.decodeByteArray(out.toByteArray(), 0, out.size());

                mainActivity.addContentView(drawOn, new WindowManager.LayoutParams(WindowManager.LayoutParams.WRAP_CONTENT, WindowManager.LayoutParams.WRAP_CONTENT));

                cnt++;
            }
        });

        if (listPreviewSizes != null) {
            previewSize = getPreviewSize(listPreviewSizes, width, height);
        }
    }

    public Camera.Size getPreviewSize(List<Camera.Size> sizes, int width, int height) {
        final double ASPECT_TOLERANCE = 0.1;
        double targetRatio = (double)width/height;

        if (sizes == null)
            return null;

        Camera.Size optimalSize = null;
        double minDiff = Double.MAX_VALUE;

        int targetHeight = height;

        for (Camera.Size size : sizes) {
            double ratio = (double)size.width/size.height;
            if (Math.abs(ratio - targetRatio) > ASPECT_TOLERANCE)
                continue;

            if (Math.abs(size.height - targetHeight) < minDiff) {
                optimalSize = size;
                minDiff = Math.abs(size.height - targetHeight);
            }
        }

        if (optimalSize == null) {
            minDiff = Double.MAX_VALUE;

            for (Camera.Size size : sizes) {
                if (Math.abs(size.height - targetHeight) < minDiff) {
                    optimalSize = size;
                    minDiff = Math.abs(size.height - targetHeight);
                }
            }
        }
        return optimalSize;
    }

    @Override
    public void surfaceCreated(SurfaceHolder surfaceHolder) {
        try {
            if (mCamera == null) {
                mCamera = Camera.open();
            }

            Camera.Parameters parameters = mCamera.getParameters();

            if (getResources().getConfiguration().orientation != Configuration.ORIENTATION_LANDSCAPE) {
                parameters.set("orientation", "portrait");
                mCamera.setDisplayOrientation(90);
                parameters.setRotation(90);
            }
            else {
                parameters.set("orientation", "landscape");
                mCamera.setDisplayOrientation(0);
                parameters.setRotation(0);
            }
            mCamera.setParameters(parameters);
            mCamera.setPreviewDisplay(surfaceHolder);

            mCamera.startPreview();

            mCamera.autoFocus(new Camera.AutoFocusCallback() {
                @Override
                public void onAutoFocus(boolean success, Camera camera) {
                    if (success) {}
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
        if (holder.getSurface() == null) {
            return;
        }

        try {
            mCamera.stopPreview();

            Camera.Parameters parameters = mCamera.getParameters();

            int rotation = MainActivity.getInstance.getWindowManager().getDefaultDisplay().getRotation();

            if (rotation == Surface.ROTATION_0) {
                mCamera.setDisplayOrientation(90);
                parameters.setRotation(90);
            }
            else if (rotation == Surface.ROTATION_90) {
                mCamera.setDisplayOrientation(0);
                parameters.setRotation(0);
            }
            else if (rotation == Surface.ROTATION_180) {
                mCamera.setDisplayOrientation(270);
                parameters.setRotation(270);
            }
            else {
                mCamera.setDisplayOrientation(180);
                parameters.setRotation(180);
            }

            parameters.setPreviewSize(previewSize.width, previewSize.height);
            mCamera.setParameters(parameters);

            mCamera.setPreviewDisplay(holder);
            mCamera.startPreview();


        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void surfaceDestroyed(SurfaceHolder holder) {
        if (mCamera != null) {
            mCamera.stopPreview();
            mCamera.release();
            mCamera = null;
        }
    }


}
