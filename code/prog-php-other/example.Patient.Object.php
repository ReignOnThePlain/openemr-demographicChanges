//Note This is just an outline.

class patient extends person {
   
    protected $_d_ethnoracial = new DataMappingObject(array("value" => NULL, "table" => "patient_flat", "column"=>"ethnoracial", "getter" => new getByFlatValue()));
   
    protected $_d_firstName => array("table" => "person_first_name", "column"=>"person_first_name", "getter" => new getByVerticleValue());
   
    
	public function ListTables() {
		$varList = get_class_vars(__CLASS__);
		$retArray = array();
		for($i=0;$i < count($varList) ;$i++){
			if(isDataObject($varList[$i})) {
				array_push($retArray,$varList[$i]['table']);
			}
		}
		return $retArray;
	}
	
	public function __get($name)
	{
		$method = '__get' . $name;
		if(method_exists($this, $method)) {
			return $this->$method();
		} 
		else if (property_exists($this, '_d_'.$name)) { 
			return $this->'_d_'.$name['getter']($this->'_d_'.$name['table'], $this->'_d_'.$name['column'], $this->id);
		else {
			throw new Exception('Invalid property to get ('.$name . ')');
		}
		
	}

	
	
	protected function isDataObject($value) {
		if(substr($value,0,3) == "_d_") {
			return true;
		}
		else { 
			return false;
		}
	}
	
} //end class


class VerticleValue {
	public static getValue($table, $column, $id) {
		return SqlQuery("Select $column from $table where $id");
	}
}