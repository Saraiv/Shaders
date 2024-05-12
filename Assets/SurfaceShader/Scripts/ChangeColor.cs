using UnityEngine;

public class ChangeColor : MonoBehaviour{
    private void OnMouseDown(){
        gameObject.GetComponent<Renderer>().material.SetColor("_Color", Color.red);
        gameObject.GetComponent<Renderer>().material.SetFloat("_Metallic", 1);
    }
}
