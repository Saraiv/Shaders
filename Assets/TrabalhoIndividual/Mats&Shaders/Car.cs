using UnityEngine;
using UnityEngine.Rendering;

public class Car : MonoBehaviour{
    public ReflectionProbe probe;

    void Update(){
        if (probe != null){
            probe.RenderProbe();
        }
    }
}
