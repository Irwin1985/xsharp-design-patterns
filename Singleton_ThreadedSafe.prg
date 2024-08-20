USING System
USING System.Threading

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.Singleton.Conceptual.ThreadedSafe
	CLASS Singleton
		PRIVATE CONSTRUCTOR
			NOP
		END CONSTRUCTOR
		
		STATIC PRIVATE _instance AS Singleton
		STATIC PRIVATE _lock := OBJECT{} AS OBJECT
		PROPERTY value AS STRING AUTO
		
		STATIC METHOD GetInstance(tcValue AS STRING) AS Singleton
			IF _instance == NULL
				BEGIN LOCK _lock
					IF _instance == NULL
						_instance := Singleton{}
						_instance:value := tcValue
					ENDIF
				END LOCK
			ENDIF
			RETURN _instance
		END METHOD
		
	END CLASS
	
	CLASS Program
		STATIC METHOD Start AS VOID
			Console.WriteLine(e"{0}\n{1}\n\n{2}\n", ;
				"If you see the same value, then singleton was reused (yay!)", ;
				"If you see different values, then 2 singletons were created (boo!!)", ;
				"RESULT:")
				
			VAR loProcess1 := Thread{{=> 
									TestSingleton("FOO")
								}}								
			VAR loProcess2 := Thread{{=>
									TestSingleton("BAR")
								}}
								
			loProcess1:Start()
			loProcess2:Start()
			
			loProcess1:Join()
			loProcess2:Join()
		END METHOD
		
		STATIC METHOD TestSingleton(tcValue AS STRING) AS VOID
			VAR loSingleton := Singleton.GetInstance(tcValue)
			Console.WriteLine(loSingleton:value)
			
		END METHOD
	END CLASS
END NAMESPACE
