Random(Min, Max) {
	Random, Out, % Min, % Max
	return out
}

m(x*) {
	for a, b in x
		text .= (IsObject(b)?pa(b):b) "`n"
	MsgBox, 0, msgbox, % text
}

pa(array, depth=5, indentLevel:="   ") {
	try {
		for k,v in Array {
			lst.= indentLevel "[" k "]"
			if (IsObject(v) && depth>1)
				lst.="`n" pa(v, depth-1, indentLevel . "    ")
			else
				lst.=" -> " v
			lst.="`n"
		} return rtrim(lst, "`r`n `t")	
	} return
}