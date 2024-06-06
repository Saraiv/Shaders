using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class postPRoss : MonoBehaviour
{
    // A Material with the Unity shader you want to process the image with
    public Material mat;

    float increment = 0;
    bool wasPressed = false;
    private void FixedUpdate()
    {
        if (Input.GetButton("Fire1"))
        {
            Vector3 mousePos = Input.mousePosition;
            //mousePos.x = mousePos.x ;
            //mousePos.y = mousePos.y ;
            mat.SetVector("_Centro", mousePos);
            {
                Debug.Log("x" + mousePos.x);
                Debug.Log("y" + mousePos.y);

            }
        }

    }

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        // Read pixels from the source RenderTexture, apply the material, copy the updated results to the destination RenderTexture
        Graphics.Blit(src, dest,mat);
    }
}
