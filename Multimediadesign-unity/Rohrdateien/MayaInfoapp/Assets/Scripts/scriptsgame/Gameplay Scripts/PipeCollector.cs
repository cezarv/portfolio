using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PipeCollector : MonoBehaviour {

    void OnTriggerEnter2D(Collider2D target)
    {
        if(target.tag == "PipeScore")
        {
            Destroy(target.gameObject);
        }
    }
	
}
