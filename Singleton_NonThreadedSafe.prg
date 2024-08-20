/*
Singleton es un patron de dise�o creacional que garantiza que tan solo
exista un objeto de su tipo y proporciona un �nico punto de acceso a �l
para cualquier otro c�digo.
*/

USING System

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.Singleton.Conceptual.NonThreadedSafe
	SEALED CLASS Singleton
		PRIVATE CONSTRUCTOR
			NOP
		END CONSTRUCTOR
		
		STATIC PRIVATE _instance AS Singleton
		
		STATIC PUBLIC METHOD GetInstance AS Singleton
			IF _instance != NULL
				_instance := Singleton{}
			ENDIF
			RETURN _instance
		END METHOD
	END CLASS	
	
	CLASS Program
		STATIC METHOD Start AS VOID
			VAR loSingleton1 := Singleton.GetInstance()
			VAR loSingleton2 := Singleton.GetInstance()
			
			IF loSingleton1 == loSingleton2
				? "Singleton works, both variables contain the same instance."
			ELSE
				? "Singleton failed, variables contain different instances."
			ENDIF
		END METHOD
	END CLASS
END NAMESPACE
