using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DistortionSpawner : MonoBehaviour {

    [SerializeField]
    private Camera
        sceneRenderCam,
        distortionRenderCam;

    [SerializeField]
    private GameObject distortionObj;

    private const int cameraOffset = 2;

    void Update()
    {

        //Quick Test code
        if (Input.GetMouseButtonDown(0))
        {
            //Translate from one vieport space to anothers to find the world point of the distortion render cam
            //This allows you to place the distortion render rig anywhere in the world and still have it work
            //Each viewport space goes from 0 to 1 in both x and y so we can just translate as long as we have a referece to the cameras
            Vector3 pos = distortionRenderCam.ViewportToWorldPoint(sceneRenderCam.ScreenToViewportPoint(Input.mousePosition));
            pos.z = distortionRenderCam.transform.position.z + cameraOffset;

            SpawnDistortion(pos);
        }
    }


    public void SpawnDistortion(Vector3 worldPos)
    {
        //TODO setup object pool for production
        Instantiate(distortionObj, worldPos, Quaternion.identity);
    }
}
