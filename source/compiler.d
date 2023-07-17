module yslm.compiler;

import std.conv;
import std.string;
import yslm.error;
import yslm.compileModule;

bool RequiredArguments(string file, size_t line, size_t required, size_t got) {
	if (got < required) {
		ErrorExpectedParameters(file, line, required, got);
		return false;
	}
	return true;
}

string[] CompileLine(
	string file, size_t line, string[] parts, bool* success, CompileModule mod
) {
	string[] ret;
	
	if (parts.length == 0) {
		return [];
	}

	switch (parts[0]) {
		case "asm": {
			ret ~= parts[1 .. $].join(" ");
			break;
		}
		case "label": {
			if (!RequiredArguments(file, line, 1, parts.length - 1)) {
				*success = false;
				return [];
			}

			ret ~= mod.CompileLabelStatement(parts[1]);
			break;
		}
		case "gosub": {
			if (!RequiredArguments(file, line, 1, parts.length - 1)) {
				*success = false;
				return [];
			}

			ret ~= mod.CompileGosub(parts[1]);
			break;
		}
		case "set_return_constant": {
			if (!RequiredArguments(file, line, 1, parts.length - 1)) {
				*success = false;
				return [];
			}

			if (!isNumeric(parts[1])) {
				ErrorExpectedInteger(file, line);
				*success = false;
				return [];
			}

			ret ~= mod.CompileReturnValueConstant(parse!ushort(parts[1]));
			break;
		}
		case "set_return_variable": {
			if (!RequiredArguments(file, line, 1, parts.length - 1)) {
				*success = false;
				return [];
			}

			ret ~= mod.CompileReturnValueVariable(parts[1]);
			break;
		}
		case "return": {
			ret ~= mod.CompileReturn();
			break;
		}
		case "to": {
			if (!RequiredArguments(file, line, 1, parts.length - 1)) {
				*success = false;
				return [];
			}

			ret ~= mod.CompileTo(parts[1]);
			break;
		}
		case "goto_if": {
			if (!RequiredArguments(file, line, 1, parts.length - 1)) {
				*success = false;
				return [];
			}

			ret ~= mod.CompileGotoIf(parts[1]);
			break;
		}
		case "goto": {
			if (!RequiredArguments(file, line, 1, parts.length - 1)) {
				*success = false;
				return [];
			}

			ret ~= mod.CompileGoto(parts[1]);
			break;
		}
		case "string": {
			if (!RequiredArguments(file, line, 1, parts.length - 1)) {
				*success = false;
				return [];
			}

			ret ~= mod.CompileString(parts[1]);
			break;
		}
		case "word": {
			if (!RequiredArguments(file, line, 1, parts.length - 1)) {
				*success = false;
				return [];
			}

			if (!isNumeric(parts[1])) {
				ErrorExpectedInteger(file, line);
				*success = false;
				return [];
			}

			ret ~= mod.CompileWord(parse!ushort(parts[1]));
			break;
		}
		case "set": {
			if (!RequiredArguments(file, line, 2, parts.length - 1)) {
				*success = false;
				return [];
			}

			if (!isNumeric(parts[2])) {
				ErrorExpectedInteger(file, line);
				*success = false;
				return [];
			}

			ret ~= mod.CompileSetConstant(parts[1], parse!ushort(parts[2]));
			break;
		}
		case "copy": {
			if (!RequiredArguments(file, line, 2, parts.length - 1)) {
				*success = false;
				return [];
			}

			ret ~= mod.CompileCopyValue(parts[1], parts[2]);
			break;
		}
		case "read": {
			if (!RequiredArguments(file, line, 1, parts.length - 1)) {
				*success = false;
				return [];
			}

			ret ~= mod.CompileRead(parts[1]);
			break;
		}
		default: {
			ErrorUnknownKeyword(file, line, parts[0]);
			*success = false;
			return [];
		}
	}
	
	return ret;
}
