function dat_bin = hex2bin(dat_hex)
% HEX2BIN	Convert hex to char of binary.
%	BIN = HEX2BIN(HEX) converts the string array HEX of hex
%	values to the character array BIN of binary values.
%

	% First convert HEX to decimal
	%  sscanf() is ~3 times faster than hex2dec but does not support
	%  code generation.
% 	str = strrep(dat_hex,' ','');
% 	dat_dec = hex2dec(reshape(char(str), 2, strlength(str)/2)');
	dat_dec = sscanf(dat_hex, '%2x');

	% Now convert decimal to binary
	dat_bin = dec2bin(dat_dec, 8);
	% dat_bin = reshape(dat_bin', 1, numel(dat_bin));

end%fcn