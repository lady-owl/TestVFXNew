using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RealTimeFps : MonoBehaviour
{
 public float updateInterval = 1.0f;

 private float _timer;
 private float _averageFramerate;
 void Update()
 {
    float smoothDeltaTime = Time.smoothDeltaTime;
    _timer = _timer <= 0 ? updateInterval : _timer -= smoothDeltaTime;

    if (_timer <= 0)
    {
        _averageFramerate = 1.0f / smoothDeltaTime;
        Debug.Log(message:$"{_averageFramerate:F2} FPS");
    }
 }

}
