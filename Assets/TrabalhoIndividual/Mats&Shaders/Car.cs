using System.Collections;
using UnityEngine;

public class Car : MonoBehaviour{
    public Material carMaterial;
    public ReflectionProbe probe;

    void FixedUpdate(){
        StartCoroutine(UpdateProbe());
    }
    IEnumerator UpdateProbe(){
        probe.RenderProbe();
        carMaterial.SetTexture("_cubeMap", probe.texture);

        yield return new WaitForSeconds(1);
    }
}
