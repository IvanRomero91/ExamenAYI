xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.paises.org";
(:: import schema at "../XSD/Paises.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/dbRef_todasLasPersonas";
(:: import schema at "../Resources/dbRef_todasLasPersonas.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/dbReferencePaises";
(:: import schema at "../Resources/dbReferencePaises.xsd" ::)

declare variable $paises as element() (:: schema-element(ns1:dbReferencePaisesOutputCollection) ::) external;
declare variable $personas as element() (:: schema-element(ns2:dbRef_todasLasPersonasOutputCollection) ::) external;
declare variable $paisesInput as element() (:: schema-element(ns3:PaisesInput) ::) external;

declare function local:func($paises as element() (:: schema-element(ns1:dbReferencePaisesOutputCollection) ::), 
                            $personas as element() (:: schema-element(ns2:dbRef_todasLasPersonasOutputCollection) ::), 
                            $paisesInput as element() (:: schema-element(ns3:PaisesInput) ::)) 
                            as element() (:: schema-element(ns3:PaisesPersonasOutput) ::) {
    <ns3:PaisesPersonasOutput>
        {
            for $pais in $paisesInput/ns3:pais
            return 

                for $dbReferencePaisesOutput in $paises/ns1:dbReferencePaisesOutput
                return
                
            if(fn:data($pais/ns3:id_pais) = fn:data($dbReferencePaisesOutput/ns1:ID_PAIS))
            then(<ns3:pais>
                    <ns3:id_pais>{fn:data($dbReferencePaisesOutput/ns1:DESCRIPCION)}</ns3:id_pais>
                    <ns3:Habitantes>
                        <ns3:Personas>
                            {
                                for $dbRef_todasLasPersonasOutput in $personas/ns2:dbRef_todasLasPersonasOutput
                                return
                                if(fn:data($dbRef_todasLasPersonasOutput/ns2:id_pais) = fn:data($dbReferencePaisesOutput/ns1:ID_PAIS))
                                then(
                                <ns3:Persona>
                                    <ns3:dni>{fn:data($dbRef_todasLasPersonasOutput/ns2:dni)}</ns3:dni>
                                    <ns3:nombre>{fn:data($dbRef_todasLasPersonasOutput/ns2:nombre)}</ns3:nombre>
                                    <ns3:apellido>{fn:data($dbRef_todasLasPersonasOutput/ns2:apellido)}</ns3:apellido>
                                    <ns3:id_pais>{fn:data($dbRef_todasLasPersonasOutput/ns2:id_pais)}</ns3:id_pais></ns3:Persona>
                                )
                                else()
                                
                                
                            }
                        </ns3:Personas>
                    </ns3:Habitantes></ns3:pais>)
            else()
                
                
        }
    </ns3:PaisesPersonasOutput>
};

local:func($paises, $personas, $paisesInput)
