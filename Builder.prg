/*
 Builder es un patrón de diseño creacional que nos permite construir objetos complejos
 paso a paso. El patrón nos permite producir distintos tipos y representaciones de un objeto
 empleando el mismo código de construcción.
*/
USING System
USING System.Collections.Generic

BEGIN NAMESPACE RefactoringGuru.DesignPatterns.Builder.Conceptual
	INTERFACE IBuilder
		METHOD BuildPartA AS VOID
		METHOD BuildPartB AS VOID
		METHOD BuildPartC AS VOID
	END INTERFACE
	
	CLASS ConcreteBuilder IMPLEMENTS IBuilder
		PRIVATE _product := Product{} AS Product
		CONSTRUCTOR
			Reset()
		END CONSTRUCTOR
		
		METHOD Reset AS VOID
			_product := Product{}
		END METHOD
		
		METHOD BuildPartA AS VOID
			_product:Add("PartA1")
		END METHOD
		
		METHOD BuildPartB AS VOID
			_product:Add("PartB1")
		END METHOD
		
		METHOD BuildPartC AS VOID
			_product:Add("PartC1")			
		END METHOD
		
		METHOD GetProduct AS Product
			VAR loResult := _product
			Reset()
			RETURN loResult
		END METHOD
	END CLASS
	
	CLASS Product
		PRIVATE _parts := List<OBJECT>{} AS List<OBJECT>

		METHOD Add(tcPart AS STRING) AS VOID
			_parts:Add(tcPart)
		END METHOD
		
		METHOD ListParts AS STRING
			VAR str := string.Empty
			
			FOR VAR i:=0 TO _parts:Count-1
				str += (STRING)_parts[i] + ", "
			END FOR
			
			str += str:Remove(str:Length-2)
			
			RETURN e"Product parts: " + str + "\n"
		END METHOD
	END CLASS
			
	CLASS Director
		PRIVATE _builder AS IBuilder
		PROPERTY Builder AS IBuilder GET _builder SET _builder := value
		
		METHOD BuildMinimalViableProduct AS VOID
			_builder:BuildPartA()
		END METHOD
		
		METHOD BuildFullFeaturedProduct AS VOID
			_builder:BuildPartA()
			_builder:BuildPartB()
			_builder:BuildPartC()
		END METHOD
	END CLASS
	
	CLASS Program
		STATIC METHOD Start AS VOID
			VAR loDirector := Director{}
			VAR loBuilder := ConcreteBuilder{}
			loDirector:Builder := loBuilder
						
			? "Standard basic product:"
			loDirector:BuildMinimalViableProduct()
			? loBuilder:GetProduct():ListParts()
			
			? "Standard full featured product:"
			loDirector:BuildFullFeaturedProduct()
			? loBuilder:GetProduct():ListParts()
			
			? "Custom product:"
			loBuilder:BuildPartA()
			loBuilder:BuildPartC()
			? loBuilder:GetProduct():ListParts()
		END METHOD
	END CLASS
END NAMESPACE
