module yslm.compileModule;

class CompileModule {
	abstract string[] CompileOrg(string org);
	abstract string[] CompileLabelStatement(string labelName);
	abstract string[] CompileGetLabel(string name);
	abstract string[] CompileGosub(string where);
	abstract string[] CompileReturnValueConstant(ushort constant);
	abstract string[] CompileReturnValueVariable(string variable);
	abstract string[] CompileReturn();
	abstract string[] CompileTo(string where);
	abstract string[] CompileGotoIf(string where);
	abstract string[] CompileGoto(string where);
	abstract string[] CompileString(string str);
	abstract string[] CompileWord(ushort word);
	abstract string[] CompileSetConstant(string where, ushort value);
	abstract string[] CompileCopyValue(string to, string from);
	abstract string[] CompileRead(string where);
}
