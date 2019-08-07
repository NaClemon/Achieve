package com.example.prac2;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.content.res.AssetFileDescriptor;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import android.app.Activity;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewManager;
import android.view.Window;
import android.view.WindowManager;
import android.view.SurfaceHolder;
import android.hardware.Camera;
import android.widget.FrameLayout;

import org.tensorflow.lite.Interpreter;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.sql.Time;
import java.util.concurrent.TimeUnit;

public class MainActivity extends AppCompatActivity {

    public static CameraPreview surfaceView;
    public static DrawOn mDraw;
    private SurfaceHolder holder;
    private static Camera mCamera;
    public static MainActivity getInstance;
    private int RESULT_PERMISSIONS = 100;
    private Interpreter tfLite;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        tfLite = getTfliteInterpreter("multi_person_mobilenet_v1_075_float.tflite");

        supportRequestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN);

        requestPermissionCamera();
    }

    public Interpreter getTfLite() {
        return tfLite;
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (RESULT_PERMISSIONS == requestCode) {
            if (grantResults.length > 0
                    && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                setInit();
            }

            return;
        }
    }

    public static Camera getCamera() {
        return mCamera;
    }

    public static DrawOn getmDraw() {
        return mDraw;
    }

    private void setInit() {
        getInstance = this;

        mCamera = Camera.open();

        FrameLayout mFrameLayout = new FrameLayout(this);

        setContentView(R.layout.activity_main);

        surfaceView = (CameraPreview) findViewById(R.id.preview);
        mDraw = new DrawOn(this);
        surfaceView.setDrawOn(mDraw);
        surfaceView.setMainActivity(this);

//        addContentView(mDraw, new WindowManager.LayoutParams(WindowManager.LayoutParams.WRAP_CONTENT, WindowManager.LayoutParams.WRAP_CONTENT));
//        ((ViewManager)mDraw.getParent()).removeView(mDraw);

        holder = surfaceView.getHolder();
        holder.addCallback(surfaceView);
        holder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);

//        findViewById(R.id.button).setOnClickListener(new View.OnClickListener() {
//            public void onClick(View view) {
//
//            }
//        });


    }


    public boolean requestPermissionCamera() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(MainActivity.this,
                    new String[]{Manifest.permission.CAMERA},
                    RESULT_PERMISSIONS);
        }
        else {
            setInit();
        }

        return true;
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
