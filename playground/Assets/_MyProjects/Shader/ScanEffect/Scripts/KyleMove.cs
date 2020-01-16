using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KyleMove : MonoBehaviour
{

  [SerializeField]
  private float waitTime = 3f;

  [SerializeField]
  private float speed = 1f;

  [SerializeField]
  private GameObject kyle;

  private bool isMove = false;

  // Use this for initialization
  void Start()
  {
    StartCoroutine(WaitWalk());
  }

  IEnumerator WaitWalk()
  {
    yield return new WaitForSeconds(waitTime);
    isMove = true;
  }

  void Update()
  {
    if (isMove)
    {
      Vector3 pos = kyle.transform.position;
      kyle.transform.position = new Vector3(pos.x, pos.y, pos.z + speed);
    }
  }
}
