module yslm.app;

import std.file;
import std.stdio;
import std.string;
import yslm.split;
import yslm.compiler;
import yslm.compileModule;
import yslm.targets.x86_16;

string appHelp = "
Usage: %s [file] <flags>

[] = required
<> = optional

Flags:
	-o [file]    = output asm file
	--org [addr] = sets org address for assembler
";

int main(string[] args) {
	string inFile;
	string outFile;
	string orgAddr;

	if (args.length <= 1) {
		writeln(appHelp.strip());
		return 0;
	}

	for (size_t i = 1; i < args.length; ++ i) {
		if (args[i][0] == '-') {
			switch (args[i]) {
				case "-o": {
					++ i;
					outFile = args[i];
					break;
				}
				case "--org": {
					++ i;
					orgAddr = args[i];
					break;
				}
				default: {
					stderr.writefln("Unknown option '%s'", args[i]);
					return 1;
				}
			}
		}
		else {
			if (inFile != "") {
				stderr.writeln("Input file set twice");
				return 1;
			}

			inFile = args[i];
		}
	}

	string[] lines = readText(inFile).split("\n");
	string[] assembly;
	bool     success = true;

	CompileModule mod = new Target_x86_16();

	if (orgAddr.length > 0) {
		assembly ~= mod.CompileOrg(orgAddr);
	}

	foreach (i, ref line ; lines) {
		auto parts  = Split(inFile, i, line, &success);
		assembly   ~= CompileLine(inFile, i, parts, &success, mod);
	}
	
	if (!success) {
		return 1;
	}

	std.file.write(outFile, assembly.join("\n"));
	
	return 0;
}
