/**************************************************
| docSCAD
| Create documentation for OpenSCAD libraries
**************************************************/

function new_help_item(signature, parameters, description) =
	[signature, parameters, description];
function help_item_signature(help_item) = help_item[0];
function help_item_parameters(help_item) = help_item[1];
function help_item_description(help_item) = help_item[2];

function new_help_item_parameter(name, type, description) =
	[name, type, description];
function parameter_name(parameter) = parameter[0];
function parameter_type(parameter) = parameter[1];
function parameter_description(parameter) = parameter[2];

function new_type(type, description) =
		[type, description];
function type_name(type) = type[0];
function type_description(type) = type[1];


module format_help(name, description, types, accessors, properties, functions, modules)
{
	num_types = len(types);
	num_accessors = len(accessors);
	num_properties = len(properties);
	num_functions = len(functions);
	num_modules = len(modules);

	echo("========================================");
	echo();
	echo(str( "Name: <b>", name, "</b>" ));
	echo(description);
	echo();
	if (num_types > 0)
	{
		echo("<u>Types</u>");
		echo();

		for (i = [0:num_types-1])
		{
			echo(str( "type <b>", type_name(types[i]), "</b> - ",type_description(types[i]) ));
		}
		echo();
	}
	if (num_accessors >0)
	{
		echo("<u>Accessors</u>");
		echo();

		for (i = [0:num_accessors-1])
			echo(str( "function <b>", help_item_signature(accessors[i]), "</b> - ", help_item_description(accessors[i]) ));

		echo();
	}
	if (num_properties > 0)
	{
		echo("<u>Properties</u>");
		echo();

		for (i = [0:num_properties-1])
		{
			echo(str( "function <b>", help_item_signature(properties[i]), "</b>" ));
			echo(str( help_item_description(properties[i]) ));
			if (len(help_item_parameters(properties[i])) > 0)
				for (j = [0:len(help_item_parameters(properties[i]))-1])
					assign(parameter = help_item_parameters(properties[i])[j])
						echo(str(
							"<b>", parameter_name(parameter), "</b> <i>", parameter_type(parameter), "</i>",
						 	parameter_description(parameter) == undef ? "" : str(" - ", parameter_description(parameter))
						));
			echo();
		}
	}
	if (num_functions > 0)
	{
		echo("<u>Functions</u>");
		echo();

		for (i = [0:num_functions-1])
		{
			echo(str( "function <b>", help_item_signature(functions[i]), "</b>" ));
			echo(str( help_item_description(functions[i]) ));
			if (len(help_item_parameters(functions[i])) > 0)
				for (j = [0:len(help_item_parameters(functions[i]))-1])
					assign(parameter = help_item_parameters(functions[i])[j])
						echo(str(
							"<b>", parameter_name(parameter), "</b> <i>", parameter_type(parameter), "</i>",
							parameter_description(parameter) == undef ? "" : str(" - ", parameter_description(parameter))
						));
			echo();
		}
	}
	if (num_modules > 0)
	{
		echo("<u>Modules</u>");
		echo();

		for (i = [0:len(modules)-1])
		{
			echo(str( "module <b>", help_item_signature(modules[i]), "</b>" ));
			echo(str( help_item_description(modules[i]) ));
			if (len(help_item_parameters(modules[i])) > 0)
				for (j = [0:len(help_item_parameters(modules[i]))-1])
					assign(parameter = help_item_parameters(modules[i])[j])
						echo(str(
							"<b>", parameter_name(parameter), "</b> <i>", parameter_type(parameter), "</i>",
							parameter_description(parameter) == undef ? "" : str(" - ", parameter_description(parameter))
						));
			echo();
		}
	}
	echo("========================================");
}

//docSCAD_help();
module docSCAD_help()
{
	name = "docSCAD.scad";
	description = "A library for creating documentation for other libraries.";
	types = [];
	accessors = [];
	properties = [];
	functions = [
		new_help_item(
			signature="new_help_item(signature, parameters, description)",
			parameters=[
				new_help_item_parameter("signature", "string", "Function signature"),
				new_help_item_parameter("parameters", "parameter list", "Function parameters"),
				new_help_item_parameter("description", "string", "Function description")],
			description="Create documentation for a new module or function."),
		new_help_item(
			signature="new_help_item_parameter(name, type, description)",
			parameters=[
				new_help_item_parameter("name", "string", "Parameter name"),
				new_help_item_parameter("type", "string", "Parameter type"),
				new_help_item_parameter("description", "string", "Parameter description")],
			description="Create documentation for a module or function parameter."),
		new_help_item(
			signature="new_type(type, description)",
			parameters=[
				new_help_item_parameter(name="type", type="type", description="Type name"),
				new_help_item_parameter(name="description", type="string", description="Type description")],
			description="Create documentation for a type")			
	];
	modules = [
		new_help_item(
			"format_help(name, description, properties, functions, modules)",
			[	new_help_item_parameter("name", "string", "Library name"),
				new_help_item_parameter("description", "string", "Library description"),
				new_help_item_parameter("types", "list of type docs", "Documentation for library types"),
				new_help_item_parameter("accessors", "list of accessor docs", "Documentation for library accessors"),
				new_help_item_parameter("properties", "list of property docs", "Documentation for library properties"),
				new_help_item_parameter("functions", "list of function docs", "Documentation for library functions"),
				new_help_item_parameter("modules", "list of module docs", "Documentation for library modules")],
			"Display documentation with formatting."),
	];

	format_help(
		name=name,
		description=description,
		types=types,
		accessors=accessors,
		properties=properties,
		functions=functions,
		modules=modules
	);
}