using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FloorMovement : MonoBehaviour {

    public float xBound;

    private Bird bird;

    void Awake()
    {
        bird = GameObject.FindObjectOfType<Bird>();
    }

    void Update () {

		if(transform.localPosition.x <= xBound)
            transform.localPosition = new Vector3(0, transform.localPosition.y,
                transform.localPosition.z);
        if(!bird.hasBirdDied)
            transform.Translate(-Time.deltaTime, 0, 0);
	}
}
