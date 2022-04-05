xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.paises.org";
(:: import schema at "../XSD/Paises.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/dbRef_todasLasPersonas";
(:: import schema at "../Resources/dbRef_todasLasPersonas.xsd" ::)

declare variable $dbRef_todasLasPersonas as element() (:: schema-element(ns1:dbRef_todasLasPersonasOutputCollection) ::) external;

declare function local:func($dbRef_todasLasPersonas as element() (:: schema-element(ns1:dbRef_todasLasPersonasOutputCollection) ::)) as element() (:: schema-element(ns2:HabitantesOutput) ::) {
    <ns2:HabitantesOutput>
        <ns2:Personas>
            {
                for $dbRef_todasLasPersonasOutput in $dbRef_todasLasPersonas/ns1:dbRef_todasLasPersonasOutput
                return 
                <ns2:Persona>
                    <ns2:dni>{fn:data($dbRef_todasLasPersonasOutput/ns1:dni)}</ns2:dni>
                    <ns2:nombre>{fn:data($dbRef_todasLasPersonasOutput/ns1:nombre)}</ns2:nombre>
                    <ns2:apellido>{fn:data($dbRef_todasLasPersonasOutput/ns1:apellido)}</ns2:apellido>
                    <ns2:id_pais>{fn:data($dbRef_todasLasPersonasOutput/ns1:id_pais)}</ns2:id_pais></ns2:Persona>
            }
        </ns2:Personas>
    </ns2:HabitantesOutput>
};

local:func($dbRef_todasLasPersonas)
