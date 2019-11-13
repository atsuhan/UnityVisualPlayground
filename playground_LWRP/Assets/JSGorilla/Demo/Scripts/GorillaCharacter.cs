using UnityEngine;
using System.Collections;

public class GorillaCharacter : MonoBehaviour {
	Animator gorillaAnimator;
	public bool jumpStart=false;
	public float groundCheckDistance = 0.1f;
	public float groundCheckOffset=0.01f;
	public bool isGrounded=true;
	public float jumpSpeed=1f;
	Rigidbody gorillaRigid;
	public float forwardSpeed;
	public float turnSpeed;

	public float walkMode=1f;
	public float jumpStartTime=0f;
	
	void Start () {
		gorillaAnimator = GetComponent<Animator> ();
		gorillaRigid=GetComponent<Rigidbody>();
	}
	
	void FixedUpdate(){
		CheckGroundStatus ();
		Move ();
		jumpStartTime+=Time.deltaTime;
	}
	
	public void Attack(){
		gorillaAnimator.SetTrigger("Attack");
	}

	public void Hit(){
		gorillaAnimator.SetTrigger("Hit");
	}
	

	public void Death(){
		gorillaAnimator.SetBool("IsLived",false);
	}
	
	public void Rebirth(){
		gorillaAnimator.SetBool("IsLived",true);
	}
	
	public void Gallop(){
		walkMode = 2f;
	}

	public void Walk(){
		walkMode = 1f;
	}	

	public void Drum(){
		gorillaAnimator.SetTrigger("Drumming");
	}

	public void Jump(){
		if (isGrounded) {
			gorillaAnimator.SetTrigger ("Jump");
			jumpStart = true;
			jumpStartTime=0f;
			isGrounded=false;
			gorillaAnimator.SetBool("IsGrounded",false);
		}
	}
	
	void CheckGroundStatus()
	{
		RaycastHit hitInfo;
		isGrounded = Physics.Raycast (transform.position + (transform.up * groundCheckOffset), Vector3.down, out hitInfo, groundCheckDistance);
		
		if (jumpStart) {
			if(jumpStartTime>.25f){
				jumpStart=false;
				gorillaRigid.AddForce((transform.up+transform.forward*forwardSpeed)*jumpSpeed,ForceMode.Impulse);
				gorillaAnimator.applyRootMotion = false;
				gorillaAnimator.SetBool("IsGrounded",false);
			}
		}
		
		if (isGrounded && !jumpStart && jumpStartTime>.5f) {
			gorillaAnimator.applyRootMotion = true;
			gorillaAnimator.SetBool ("IsGrounded", true);
		} else {
			if(!jumpStart){
				gorillaAnimator.applyRootMotion = false;
				gorillaAnimator.SetBool ("IsGrounded", false);
			}
		}
	}
	
	public void Move(){
		gorillaAnimator.SetFloat ("Forward", forwardSpeed);
		gorillaAnimator.SetFloat ("Turn", turnSpeed);

	}
}
