using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bird : MonoBehaviour
{
    private Rigidbody2D myBody;
    private Animator anim;

    public AudioClip deathClip, flyClip, scoreClip;

    public float jumpForce;
    public float xSpeed;
    public float rotationUp, rotationDown;

    private int score;

    [HideInInspector]
    public bool hasTheGameStarted, hasBirdDied;

    Vector3 birdRotation;

	void Awake ()
    {
        anim = GetComponent<Animator>();
        myBody = GetComponent<Rigidbody2D>();	
	}

    void Update()
    {
        if (hasTheGameStarted && !hasBirdDied)
        {
            FixBirdRotation();
            XMovement();
        }

        if (hasBirdDied)
            anim.speed = 0;

        SpeedUp();

    }

    void FixedUpdate ()
    {
        if(hasTheGameStarted && !hasBirdDied)
        {
            JumpMovement();
        }
        else
        {
            if (myBody.velocity.y < -1 && !hasBirdDied)
                myBody.velocity = Vector2.up * jumpForce * .365f;
            if(Input.GetKeyDown(KeyCode.Space) || Input.GetMouseButtonDown(0))
            {
                hasTheGameStarted = true;
                if (!hasBirdDied)
                    myBody.velocity = Vector2.up * jumpForce;
            }
        }
	}

    void SpeedUp()
    {
        if (score == 5)
            xSpeed = 1.1f;
        else if (score == 10)
            xSpeed = 1.3f;
        else if (score == 15)
            xSpeed = 1.5f;
    }

    void JumpMovement()
    {
        if(Input.GetMouseButtonDown(0) || Input.GetKeyDown(KeyCode.Space))
        {
            myBody.velocity = Vector2.up * jumpForce;
            AudioSource.PlayClipAtPoint(flyClip, transform.position);
        }
    }

    void XMovement()
    {
        transform.position += new Vector3(Time.smoothDeltaTime * xSpeed, 0);
    }

    void FixBirdRotation()
    {
        float degreesToAdd = 0;

        if (myBody.velocity.y <= 0)
            degreesToAdd = rotationDown;
        if (myBody.velocity.y > 0)
            degreesToAdd = rotationUp;

        birdRotation = new Vector3(0, 0, Mathf.Clamp(birdRotation.z + degreesToAdd,
            -90, 30));
        transform.eulerAngles = birdRotation;

    }

    void OnTriggerEnter2D(Collider2D targret)
    {
        if(targret.tag == "Pipe")
        {
            if (!hasBirdDied)
                AudioSource.PlayClipAtPoint(deathClip, transform.position);
            hasBirdDied = true;
            
        }

        if(targret.tag == "PipeScore")
        {
            score++;
            PlayerPrefs.SetInt("Score", score);
            AudioSource.PlayClipAtPoint(scoreClip, transform.position);
        }

    }

    void OnCollisionEnter2D(Collision2D target)
    {
        if(target.gameObject.tag == "Ground")
        {
            if (!hasBirdDied)
                AudioSource.PlayClipAtPoint(deathClip, transform.position);
            hasBirdDied = true;
        }
    }
}
