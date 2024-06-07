using UnityEngine;

public class DetectTeste : MonoBehaviour{
    public Material mat;
    public Vector3 position;
    
    void OnTriggerEnter(Collider collision) {
        Debug.Log("Entrou " + collision.transform.position);
        mat.SetVector("_Position", collision.transform.position);
    }
}
