using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour {

    private Transform bird;

    public float offSetX = 0.5f;
	
	void Awake ()
    {
        bird = GameObject.Find("Flappy Bird").transform;	
	}
	
	void Update () {
        transform.position = new Vector3(bird.position.x + offSetX, 0,
            transform.position.z);
	}
}
