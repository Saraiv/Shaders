using UnityEngine;

public class PostProcessing : MonoBehaviour{
    // A Material with the Unity shader you want to process the image with
    public Material mat;

     float increment = 0;
    bool wasPressed = false;
    private void FixedUpdate()
    {
        if (Input.GetButton("Fire1"))
        {
            Vector3 mousePos = Input.mousePosition;
            mat.SetVector("_Centro", mousePos);
        }
        if (Input.GetButton("Fire2"))
        {
            Vector3 mousePos = Input.mousePosition;
            mat.SetVector("_Centro2", mousePos);
        }

    }



    void OnRenderImage(RenderTexture src, RenderTexture dest)
{
        // Read pixels from the source RenderTexture, apply the material, copy the updated results to the destination RenderTexture
        Graphics.Blit(src, dest, mat);
    }
}
