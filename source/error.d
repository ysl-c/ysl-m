module yslm.error;

import std.stdio;
import core.stdc.stdlib;

void ErrorBegin(string fname, size_t line) {
	version (Windows) {
		stderr.writef("%s:%d: error: ", fname, line + 1);
	}
	else {
		stderr.writef("\x1b[1m%s:%d: \x1b[31merror:\x1b[0m ", fname, line + 1);
	}
}
void ErrorUnknownEscape(string fname, size_t line, char ch) {
	ErrorBegin(fname, line);
	stderr.writefln("Unknown escape sequence \\%c", ch);
}

void ErrorExpectedParameters(string fname, size_t line, ulong expected, ulong got) {
	ErrorBegin(fname, line);
	stderr.writefln("Expected %d parameters, got %d", expected, got);
}

void ErrorExpectedInteger(string fname, size_t line) {
	ErrorBegin(fname, line);
	stderr.writeln("Expected integer");
}

void ErrorUnknownKeyword(string fname, size_t line, string keyword) {
	ErrorBegin(fname, line);
	stderr.writefln("Unknown keyword '%s'", keyword);
}
