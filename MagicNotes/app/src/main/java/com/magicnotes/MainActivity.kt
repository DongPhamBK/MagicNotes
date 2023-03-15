package com.magicnotes

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        //Đơn giản mà hiệu quả
        //Chính là tính năng của bàn phím này
        //Yên tĩnh thích hợp lắm!
        Toast.makeText(this, "Hello", Toast.LENGTH_SHORT).show()

    }
}