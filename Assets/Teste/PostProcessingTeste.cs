using UnityEngine;

public class PostProcessingTeste : MonoBehaviour{
    public Material mat;

    void OnRenderImage(RenderTexture src, RenderTexture dest){
        Graphics.Blit(src, dest, mat);
    }
}
