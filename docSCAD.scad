/**************************************************
| docSCAD
| Create documentation for OpenSCAD libraries
**************************************************/
use <davidson16807-relativity.scad/strings.scad>;

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

function new_member(name, description, parameters, returnValue) =
	[name, description, parameters, returnValue];
function memberName(member) = member[0];
function memberDescription(member) = member[1];
function memberParameters(member) = member[2];
function memberReturnValue(member) = member[3];

// parameter formatting functions for formatHelp_simple()
function String(paramName, paramDesc) =
	str("string <b>", paramName, "</b> ", paramDesc);
function Number(paramName, paramDesc) =
	str("number <b>", paramName, "</b> ", paramDesc);
function Boolean(paramName, paramDesc) =
	str("boolean <b>", paramName, "</b> ", paramDesc);
function List(listType, paramName, paramDesc) =
	str("[", listType, "] <b>", paramName, "</b> ", paramDesc);
function Optional(param) =
	str("<i>optional</i> ", param);

module formatHelp_simple(libraryName, description, members)
{
	_name = str("<h1>", libraryName, "</h1>");
	_description = str("<p>", description, "</p>");

	_descriptions =
		len(members)==0?
			[]:
			[
				for(i=[0:len(members)-1])
					[
						for(j=[0:len(memberDescription(members[i]))-1])
							str( "| ", memberDescription(members[i])[j], "<br>" )
					]
			];

	_members =
		len(members)==0?
			[]:
			[
				for(i=[0:len(members)-1])
					str(
						"<br>",
						"<u><b>", memberName(members[i]), "</b>",
						(memberParameters(members[i])!=undef?str(" ( <i>", memberParameters(members[i]),"</i> )"):" ()"),
						(memberReturnValue(members[i])!=undef?str(" = ", memberReturnValue(members[i])):""), 
						"</u><br>",
						join(_descriptions[i])
					)
			];

	echo(str( _name, _description ));
	if (len(_members)>0)
		for (i=[0:len(_members)-1])
			echo(_members[i]);
}

module format_help(name, description, types, accessors, properties, functions, modules)
{
	echo("<b>## DEPRECATED ##</b>: docSCAD.format_help()");
	formatHelp(name, description, types, accessors, properties, functions, modules);
}

module formatHelp(name, description, types, accessors, properties, functions, modules)
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
				{
					//assign(parameter = help_item_parameters(properties[i])[j])
					parameter = help_item_parameters(properties[i])[j];
					echo(str(
						"<b>", parameter_name(parameter), "</b> <i>", parameter_type(parameter), "</i>",
					 	parameter_description(parameter) == undef ? "" : str(" - ", parameter_description(parameter))
					));
				}
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
				{
					//assign(parameter = help_item_parameters(functions[i])[j])
					parameter = help_item_parameters(functions[i])[j];
					echo(str(
						"<b>", parameter_name(parameter), "</b> <i>", parameter_type(parameter), "</i>",
						parameter_description(parameter) == undef ? "" : str(" - ", parameter_description(parameter))
					));
				}
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
				{
					//assign(parameter = help_item_parameters(modules[i])[j])
					parameter = help_item_parameters(modules[i])[j];
					echo(str(
						"<b>", parameter_name(parameter), "</b> <i>", parameter_type(parameter), "</i>",
						parameter_description(parameter) == undef ? "" : str(" - ", parameter_description(parameter))
					));
				}
			echo();
		}
	}
	echo("========================================");
}

docSCAD_help();
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
			"formatHelp(name, description, types, accessors, properties, functions, modules)",
			[	new_help_item_parameter("name", "string", "Library name"),
				new_help_item_parameter("description", "string", "Library description"),
				new_help_item_parameter("types", "list of type docs", "Documentation for library types"),
				new_help_item_parameter("accessors", "list of accessor docs", "Documentation for library accessors"),
				new_help_item_parameter("properties", "list of property docs", "Documentation for library properties"),
				new_help_item_parameter("functions", "list of function docs", "Documentation for library functions"),
				new_help_item_parameter("modules", "list of module docs", "Documentation for library modules")],
			"Display documentation with formatting."),
	];

	*format_help(
		name=name,
		description=description,
		types=types,
		accessors=accessors,
		properties=properties,
		functions=functions,
		modules=modules
	);

	formatHelp_simple(
		libraryName="docSCAD.scad",
		description=join([
			"Console documentation for OpenSCAD",
			"<p>",
			"Example:",
			"<pre>
module library_help()\n
  formatHelp_simple(\n
    libraryName=\"library.scad\",\n
    description=\"Some description\",\n
    members=[new_member(name, \[description\], \[parameters\], returnValue]\n
  );</pre>"
		]),
		members=[
			new_member(
				name="formatHelp",
				description=[
					"name = Library name",
					"description = Description of library",
					"types = List of types",
					"accessors = List of accessors",
					"properties = List of properties",
					"functions = List of functions",
					"modules = List of modules"
				],
				parameters="name, description, types, accessors, properties, functions, modules"
			),
			new_member(
				name="formatHelp_simple",
				description=[
					String("libraryName", "Name of library"),
					String("description", "Description of library"),
					List("member", "members", "List of members in the library")
				],
				parameters="libraryName, description, members"
			),
			new_member(
				name="new_member",
				description=[
					"Create a new member function/module/etc. for <b>formatHelp_simple()</b>",
					"",
					String("name", "Function/module name"),
					List("string", "description", "Function/module description (one line per element)"),
					Optional(String("parameters", "Function/method signature")),
					Optional(String("returnType", ""))
				],
				parameters="name, description[, parameters][, returnType]"
			),
			new_member(
				name="String",
				description=[
					"Create a formatted string parameter for <b>new_member()</b>, e.g.:",
					str("&nbsp;&nbsp;&nbsp;&nbsp;", String("paramName", "paramDesc")),
				],
				parameters="paramName, paramDesc"
			),
			new_member(
				name="Number",
				description=[
					"Create a formatted number parameter for <b>new_member()</b>, e.g.:",
					str("&nbsp;&nbsp;&nbsp;&nbsp;", Number("paramName", "paramDesc")),
				],
				parameters="paramName, paramDesc"
			),
			new_member(
				name="Boolean",
				description=[
					"Create a formatted number parameter for <b>new_member()</b>, e.g.:",
					str("&nbsp;&nbsp;&nbsp;&nbsp;", Boolean("paramName", "paramDesc")),
				],
				parameters="paramName, paramDesc"
			),
			new_member(
				name="List",
				description=["Create a formatted list parameter for <b>new_member()</b>, e.g.:",
					str("&nbsp;&nbsp;&nbsp;&nbsp;", List("listType", "paramName", "paramDesc")),
				],
				parameters="listType, paramName, paramDesc"
			),
			new_member(
				name="Optional",
				description=["Create a formatted optional parameter for <b>new_member()</b>",
					str("&nbsp;&nbsp;&nbsp;&nbsp;", Optional(String("paramName", "paramDesc"))),
				],
				parameters="param"
			)
		]
	);
}