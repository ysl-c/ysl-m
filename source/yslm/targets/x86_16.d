module yslm.targets.x86_16;

import std.format;
import yslm.compileModule;

class Target_x86_16 : CompileModule {
	override string[] CompileOrg(string org) {
		return [format("org %s", org)];
	}

	override string[] CompileLabelStatement(string labelName) {
		return [format("%s:", labelName)];
	}

	override string[] CompileGosub(string where) {
		return [format("call %s", where)];
	}

	override string[] CompileReturnValueConstant(ushort constant) {
		return [format("mov ax, %d", constant)];
	}

	override string[] CompileReturnValueVariable(string variable) {
		return [format("mov ax, [%s]", variable)];
	}

	override string[] CompileReturn() {
		return ["ret"];
	}

	override string[] CompileTo(string where) {
		return ["mov [%s], ax", where];
	}

	override string[] CompileGotoIf(string where) {
		return [format("jz %s", where)];
	}

	override string[] CompileGoto(string where) {
		return [format("jmp %s", where)];
	}

	override string[] CompileString(string str) {
		string ret = "db ";

		foreach (ref ch ; str) {
			ret ~= format("%d, ", ch);
		}

		ret ~= "0";
		return [ret];
	}

	override string[] CompileWord(ushort word) {
		return [format("dw %d", word)];
	}

	override string[] CompileSetConstant(string where, ushort value) {
		return [format("mov word [%s], %d", where, value)];
	}

	override string[] CompileCopyValue(string to, string from) {
		return [format("mov bx, [%s]", from), format("mov [%s], bx", to)];
	}

	override string[] CompileRead(string where) {
		return [format("mov ax, [%s]", where)];
	}
}
