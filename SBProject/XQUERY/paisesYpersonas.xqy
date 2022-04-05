xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.paises.org";
(:: import schema at "../XSD/Paises.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/dbReferencePaises";
(:: import schema at "../Resources/dbReferencePaises.xsd" ::)

declare variable $paises as element() (:: schema-element(ns1:dbReferencePaisesOutputCollection) ::) external;

declare function local:func($paises as element() (:: schema-element(ns1:dbReferencePaisesOutputCollection) ::)) as element() (:: schema-element(ns2:PaisesOutput) ::) {
    <ns2:PaisesOutput>
        {
            for $dbReferencePaisesOutput in $paises/ns1:dbReferencePaisesOutput
            return 
            <ns2:pais>
                <ns2:id_pais>{fn:data($dbReferencePaisesOutput/ns1:ID_PAIS)}</ns2:id_pais>
                <ns2:pais>{fn:data($dbReferencePaisesOutput/ns1:DESCRIPCION)}</ns2:pais></ns2:pais>
        }
    </ns2:PaisesOutput>
};

local:func($paises)
