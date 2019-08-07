package com.example.tfliteprac;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.provider.DocumentsContract;
import android.provider.OpenableColumns;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import android.app.Activity;
import android.content.res.AssetFileDescriptor;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import android.app.Fragment;

import org.tensorflow.lite.Interpreter;
import org.w3c.dom.Text;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;

import android.provider.MediaStore;
import android.database.Cursor;

public class MainActivity extends AppCompatActivity {

    private static Music list;
    private static final int READ_REQUEST_CODE = 42;

    private static final int FROM_ALBUM = 1;
    private static final int FROM_CAMERA = 2;

    private static final String TAG = "MainActivity";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

//        final TextView tv_output = findViewById(R.id.tv_output);

        findViewById(R.id.button).setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
//                try {
////                    performFileSearch(tv_output);
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
                Intent intent = new Intent();
                intent.setType("image/*");
                intent.setAction(Intent.ACTION_GET_CONTENT);
                startActivityForResult(intent, FROM_ALBUM);
            }
        });
    }

    public void onActivityResult(int requestCode, int resultCode, Intent resultData) {
        if (requestCode == READ_REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            try {
                InputStream stream = getContentResolver().openInputStream(resultData.getData());
                Bitmap bmp = BitmapFactory.decodeStream(stream);
                stream.close();

                ImageView iv = findViewById(R.id.photo);
                iv.setScaleType(ImageView.ScaleType.FIT_XY);
                iv.setImageBitmap(bmp);

                float[][] fileInfo = new float[1][784];

                for (int i = 0; i < 28; i++) {
                    for (int j = 0; j < 28; j++) {
                        int temp = bmp.getPixel(i, j);
                        fileInfo[0][i*28 + j] = (temp & 0xff) / (float)255;
                    }
                }

                Interpreter tflite = getTfliteInterpreter("mnist.tflite");

                float[][] output = new float[1][10];
                tflite.run(fileInfo, output);

                int[] id_array = { R.id.result_0,
                        R.id.result_1,
                        R.id.result_2,
                        R.id.result_3,
                        R.id.result_4,
                        R.id.result_5,
                        R.id.result_6,
                        R.id.result_7,
                        R.id.result_8,
                        R.id.result_9 };

                for (int i = 0; i < 10; i++) {
                    TextView tv = findViewById(id_array[i]);
                    tv.setText(String.format("%.5f", output[0][i]));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

//            Uri uri = null;
//            if (resultData != null) {
//                uri = resultData.getData();
//                String filePath = getRealPathFromURI(uri);
//                String a = uri.getPath();
////                Log.i(TAG, "Uri: " + uri.toString());
////                tv_output.setText(dumpMetaData(uri));
//                Log.i(TAG, "file path: " + filePath);
//                tv_output.setText(a);
//            }
        }
    }


//    public void performFileSearch(TextView tv_output) {
//        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
//
//        intent.addCategory(Intent.CATEGORY_OPENABLE);
//
//        intent.setType("*/*");
//        startActivityForResult(intent, READ_REQUEST_CODE);
//        onActivityResult(READ_REQUEST_CODE, Activity.RESULT_OK, intent, tv_output);
//    }



    public String getRealPathFromURI(Uri uri) {
        String filePath = "";
//        filePath = uri.getPath();
//        if (filePath.startsWith("/storage"))
//            return filePath;

        String wholeID = DocumentsContract.getDocumentId(uri);
        String id = wholeID.split(":")[1];
        Log.e(TAG, "id = " + id);
        String[] column = { MediaStore.Files.FileColumns.DATA };
        String sel = MediaStore.Files.FileColumns.DATA + " LIKE '%" + id + "%'";

        Cursor cursor = getContentResolver().query(MediaStore.Files.getContentUri("external"),
                column, sel, null, null);

        int columnIndex = cursor.getColumnIndex(column[0]);

        if (cursor.moveToFirst()) {
            filePath = cursor.getString(columnIndex);
        }
        cursor.close();

        return filePath;
    }

    public String dumpMetaData(Uri uri) {
        Cursor cursor = getContentResolver().query(uri, null, null, null,
                null, null);
        String displayName = null;
        try {
            if (cursor != null && cursor.moveToFirst()) {
                displayName = cursor.getString(cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME));
                Log.i(TAG, "Display Name: " + displayName);

                int sizeIndex = cursor.getColumnIndex(OpenableColumns.SIZE);
                String size = null;
                if (!cursor.isNull(sizeIndex)) {
                    size = cursor.getString(sizeIndex);
                } else {
                    size = "Unknown";
                }
                Log.i(TAG, "Size: " + size);
            }
        } finally {
            Log.i(TAG, "Error");
            cursor.close();
        }
        return displayName;
    }

    public void getMusic() {
        list = new Music();

        String[] projection = {
                MediaStore.Audio.Media._ID,
                MediaStore.Audio.Media.TITLE,
                MediaStore.Audio.Media.DATA
        };

        Cursor cursor = getContentResolver().query(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI, projection, null, null, null);

        list.setId(cursor.getLong(cursor.getColumnIndex(MediaStore.Audio.Media._ID)));
        list.setTitle(cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.TITLE)));
        list.setDataPath(cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DATA)));

        cursor.close();
    }

    private String makeOutputText(String title, float[][] output_1, int[][] output_2) {
        String result = title + "\n";
        for (int i = 0; i < output_1.length; i++)
            result += String.valueOf(output_1[i][0]) + " : ";

        if(output_2 != null) {
            result += "\n";
            for (int i = 0; i < output_2.length; i++)
                result += String.valueOf(output_2[i][0]) + " : ";
        }

        return result;
    }

    private Interpreter getTfliteInterpreter(String modelPath) {
        try {
            return new Interpreter(loadModelFile(MainActivity.this, modelPath));
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    private MappedByteBuffer loadModelFile(Activity activity, String modelPath) throws IOException {
        AssetFileDescriptor fileDescriptor = activity.getAssets().openFd(modelPath);
        FileInputStream inputStream = new FileInputStream(fileDescriptor.getFileDescriptor());
        FileChannel fileChannel = inputStream.getChannel();

        long startOffset = fileDescriptor.getStartOffset();
        long declaredLength = fileDescriptor.getDeclaredLength();

        return fileChannel.map(FileChannel.MapMode.READ_ONLY, startOffset, declaredLength);
    }

}
