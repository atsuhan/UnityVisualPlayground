using UnityEngine;
using System.Collections;

public class GorillaUserController : MonoBehaviour {
	GorillaCharacter gorillaCharacter;
	
	void Start () {
		gorillaCharacter = GetComponent < GorillaCharacter> ();
	}
	
	void Update () {	
		if (Input.GetButtonDown ("Fire1")) {
			gorillaCharacter.Attack();
		}
		if (Input.GetButtonDown ("Jump")) {
			gorillaCharacter.Jump();
		}
		if (Input.GetKeyDown (KeyCode.H)) {
			gorillaCharacter.Hit();
		}
		if (Input.GetKeyDown (KeyCode.K)) {
			gorillaCharacter.Death();
		}
		if (Input.GetKeyDown (KeyCode.L)) {
			gorillaCharacter.Rebirth();
		}		
		if (Input.GetKeyDown (KeyCode.R)) {
			gorillaCharacter.Gallop();
		}				
		if (Input.GetKeyUp (KeyCode.R)) {
			gorillaCharacter.Walk();
		}		
		if (Input.GetKeyDown (KeyCode.U)) {
			gorillaCharacter.Drum();
		}	

		gorillaCharacter.forwardSpeed= gorillaCharacter.walkMode*Input.GetAxis ("Vertical");
		gorillaCharacter.turnSpeed= Input.GetAxis ("Horizontal");
	}
}
