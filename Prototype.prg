/*
Prototype es un patrón de diseño creacional que permite la clonación de objetos, incluso objetos complejos,
sin acoplarse a sus clases específicas.
*/                                     

USING System

BEGIN NAMESPACE RegactoringGuru.DesignPatterns.Prototype.Conceptual
	CLASS Person
		PUBLIC Age AS INT
		PUBLIC BirthDate AS DateTime
		PUBLIC Name AS STRING
		PUBLIC IdInfo AS IdInfo
		
		METHOD ShallowCopy AS Person
			RETURN (Person) SELF:MemberwiseClone()
		END METHOD
		
		METHOD DeepCopy AS Person
			VAR loPerson := (Person)SELF:MemberwiseClone()
			loPerson:IdInfo := IdInfo{IdInfo:IdNumber}
			loPerson:Name := String.Copy(Name)
			
			RETURN loPerson
		END METHOD		
	END CLASS
	
	CLASS IdInfo
		PUBLIC IdNumber AS INT
		CONSTRUCTOR(tnIdNumber AS INT)
			IdNumber := tnIdNumber
		END CONSTRUCTOR
	END CLASS
	
	CLASS Program
		STATIC METHOD Start AS VOID
			VAR loP1 := Person{}
			loP1:Age := 38
			loP1:BirthDate := Convert.ToDateTime("1985-11-15")
			loP1:Name := "Irwin"
			loP1:IdInfo := IdInfo{666}
			
			// Realizamos una copia superficial y la asignamos a loP2
			VAR loP2 := loP1:ShallowCopy()
			// Realizamos una copia profunda y la asignamos a loP3
			VAR loP3 := loP1:DeepCopy()
			
			// Ahora mostramos los valores de loP1, loP2 y loP3
			?"Valores originales de loP1, loP2, loP3"
			?"   valores de la instancia loP1"
			DisplayValues(loP1)
			?"   valores de la instancia loP2"
			DisplayValues(loP2)
			?"   valores de la instancia loP3"
			DisplayValues(loP3)
			
			// Cambiamos el valor de las propiedades de loP1 y mostramos
			// nuevamente los datos de los 3 objetos.
			
			loP1:Age := 34
			loP1:BirthDate := Convert.ToDateTime("1989-12-23")
			loP1:Name := "Serelys"
			loP1:IdInfo:IdNumber := 7878
			
			?e"\nValores de loP1, loP2 y loP3 tras los cambios de loP1:"
			?"   valores de la instancia loP1"
			DisplayValues(loP1)
			?"   valores de la instancia loP2"
			DisplayValues(loP2)
			?"   valores de la instancia loP3"
			DisplayValues(loP3)				
		END METHOD
		STATIC PRIVATE METHOD DisplayValues(toPerson AS Person) AS VOID
			Console.WriteLine("    Name: {0:s}, Age: {1:d}, BirthDate: {2:MM/dd/yy}", toPerson:Name, toPerson:Age, toPerson:BirthDate)
			Console.WriteLine("    ID#: {0:d}", toPerson:IdInfo:IdNumber)
		END METHOD
	END CLASS
END NAMESPACE
