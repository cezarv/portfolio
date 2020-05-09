using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class GameplayController : MonoBehaviour {

    private Bird bird;

    public Text scoreText, scoreBoardText, highScoreBoradText;
    public GameObject getReady, scoreBoardPanel, silverMedal, goldMedal;

    private int score;

	void Awake ()
    {
        bird = GameObject.FindObjectOfType<Bird>();
        PlayerPrefs.SetInt("Score", 0);
	}
	
	void Update ()
    {
        if (bird.hasTheGameStarted)
            getReady.SetActive(false);

        if (bird.hasBirdDied)
            scoreBoardPanel.SetActive(true);

        ScoreUpdate();
        SetTheMedal();
	}

    void SetTheMedal()
    {
        if (score >= 10 && score < 20)
            silverMedal.SetActive(true);
        else if (score >= 20)
            goldMedal.SetActive(true);
        else
        {
            silverMedal.SetActive(false);
            goldMedal.SetActive(false);
        }
    }

    void SetNewHighScore()
    {
        if(score > PlayerPrefs.GetInt("HighScore"))
        {
            PlayerPrefs.SetInt("HighScore", score);
        }
    }

    void ScoreUpdate()
    {
        score = PlayerPrefs.GetInt("Score", 0);
        scoreText.text = score.ToString();

        scoreBoardText.text = score.ToString();
        highScoreBoradText.text = PlayerPrefs.GetInt("HighScore", 0).ToString();

        SetNewHighScore();
    }

    public void PlayAgain()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    }

    public void GoToMenu()
    {
        SceneManager.LoadScene("MainMenu");
    }

}
