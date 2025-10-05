package macro;

#if !display
#if macro
@:nullSafety
class FlxMacro
{
	/**
	 * A macro to be called targeting the `FlxBasic` class.
	 * @return An array of fields that the class contains.
	 */
	public static macro function buildFlxBasic():Array<haxe.macro.Expr.Field>
	{
		// The FlxBasic class. We can add new properties to this class.
		var cls:haxe.macro.Type.ClassType = haxe.macro.Context.getLocalClass().get();
		// The fields of the FlxClass.
		var fields:Array<haxe.macro.Expr.Field> = haxe.macro.Context.getBuildFields();

		haxe.macro.Context.info('[INFO] ${cls.name}: Adding [string_ID, update_callback] attributes...', haxe.macro.Context.currentPos());

		// Here, we add the attributes to all FlxBasic objects.
		// This has no functional code tied to it, but it can be used as a target value
		// for the FlxTypedGroup.sort method, to rearrange the objects in the scene.
		fields = fields.concat([
			{
				name: "string_ID", // Field name.
				access: [haxe.macro.Expr.Access.APublic], // Access level
				kind: haxe.macro.Expr.FieldType.FVar(macro :String, macro $v{''}), // Variable type and default value
				pos: haxe.macro.Context.currentPos(), // The field's position in code.
			}
		]);

		fields = fields.concat([
			{
				name: "update_callback", // Field name.
				access: [haxe.macro.Expr.Access.APublic], // Access level
				kind: haxe.macro.Expr.FieldType.FVar(macro :Void->Void, macro $v{null}), // Variable type and default value
				pos: haxe.macro.Context.currentPos(), // The field's position in code.
			}
		]);

		return fields;
	}
}
#end
#end
