using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spawner : MonoBehaviour {

    private Bird bird;

    public GameObject pipe;

    public float timerMin, timerMax;
    public float yBoundMin, yBoundMax;

    private bool startSpawning;

	void Awake () {
        bird = GameObject.FindObjectOfType<Bird>();
	}
	
	void Update () {

		if(bird.hasTheGameStarted && !startSpawning)
        {
            StartCoroutine(SpawnPipe());
            startSpawning = true;
        }

        if (bird.hasBirdDied)
            StopAllCoroutines();
	}

    IEnumerator SpawnPipe()
    {
        yield return new WaitForSeconds(Random.Range(timerMin, timerMax));

        Instantiate(pipe, new Vector2(transform.position.x, Random.Range(yBoundMin, yBoundMax)),
            Quaternion.identity);

        StartCoroutine(SpawnPipe());

    }

}
