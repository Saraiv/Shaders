using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Temple : MonoBehaviour{
    float valor = 0;

    void Update(){

        if (Input.GetKeyDown(KeyCode.B)){
            valor += 1;
            this.gameObject.GetComponent<Renderer>().material.SetFloat("_LimiteBuild", valor);
        }
    }
}
