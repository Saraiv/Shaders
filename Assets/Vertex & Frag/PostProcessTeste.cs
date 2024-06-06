using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class PostProcessTeste : MonoBehaviour{
    public Material mat;
    public List<Vector3> points = new List<Vector3>();
    public bool clicked, clickedTwo = false;
    public int count = 0;

    public void Start(){
        count = 0;
        points.Clear();

        mat.SetVector("_PointOne", new Vector3(0, 0, 0));
        mat.SetVector("_PointTwo", new Vector3(0, 0, 0));
        mat.SetVector("_PointThree", new Vector3(0, 0, 0));

    }

    private void FixedUpdate(){
        if (Input.GetMouseButtonDown(0) && !clicked){
            clicked = true;
            Vector3 mousePos = Input.mousePosition;
            mousePos.x = mousePos.x / Screen.width  ;
            mousePos.y =  mousePos.y / Screen.height ;
            Debug.Log("Fire1: x" + mousePos.x);
            Debug.Log("Fire1: y" + mousePos.y);
            points.Add(mousePos);
        }
        if(Input.GetMouseButtonDown(1) && !clickedTwo){
            clickedTwo = true;
            Vector3 mousePos = Input.mousePosition;
            mousePos.x = mousePos.x / Screen.width  ;
            mousePos.y =  mousePos.y / Screen.height ;
            Debug.Log("Fire2: x" + mousePos.x);
            Debug.Log("Fire2: y" + mousePos.y);
            
            mat.SetVector("_PointThree", mousePos);
        }
        if(Input.GetMouseButtonUp(0) && clicked){
            clicked = false;
        }

        if(points.Count >= 2){
            mat.SetVector("_PointOne", points[0]);
            mat.SetVector("_PointTwo", points[1]);
        }
    }

    void OnRenderImage(RenderTexture src, RenderTexture dest){
        // Read pixels from the source RenderTexture, apply the material, copy the updated results to the destination RenderTexture
        Graphics.Blit(src, dest, mat);
    }
}
