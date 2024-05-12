using UnityEngine;

public class IsPlayerMoving : MonoBehaviour{
    public Transform player;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Vector3.Distance(player.position, transform.position) < 20){
            GetComponent<Renderer>().material.SetInt("_moving", 1);
        }
        else{
            GetComponent<Renderer>().material.SetInt("_moving", 0);
        }
    }
}
