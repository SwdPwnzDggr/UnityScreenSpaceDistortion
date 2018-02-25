using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//Used to test the displacement objects
public class ScaleOverTime : MonoBehaviour
{
    private const float speed = 10f;
    private const float maxScale = 100f;

	void Update ()
    {
        //Scales up to create the ripple effect
        transform.localScale += transform.localScale * speed * Time.deltaTime;

        //Destroying only because this is a demo
        //TODO create obj pool for demo
        if (transform.localScale.x > maxScale)
            Destroy(this.gameObject);
	}
}