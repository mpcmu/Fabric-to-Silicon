from optparse import OptionParser

CLB_X = 4
CLB_Y = 4
IOB_X = 1
IOB_Y = 1

PRIORITY = 10
TYPE = "clb"
IOB_PRIORITY = 100
IOB_TYPE = "io"
IOB_CAPACITY = 8

parser = OptionParser()
parser.add_option("-i", "--iob",
                  action="store_true", dest="iob", default=False)
parser.add_option("-c", "--clb",
                  action="store_true", dest="clb", default=False)
parser.add_option("-x", "--xbar",
                  action="store_true", dest="xbar", default=False)
opt, args = parser.parse_args()

if opt.iob:
	print('<!-- IOBs -->')
	for i in [0, CLB_X+IOB_X*2-1]:
		for j in range(CLB_Y+IOB_Y*2):
			print('<single priority="{0}" type="{1}" x="{2}" y="{3}">'.format(IOB_PRIORITY, IOB_TYPE, i, j))
			print('\t<metadata>')
			prefix_str = ""
			for c in range(IOB_CAPACITY):
				prefix_str += "{0}_{1}_{2}_{3}".format(IOB_TYPE, i, j, c)
				if c != IOB_CAPACITY-1: prefix_str += " "
			print('\t\t<meta name="fasm_prefix">{0}</meta>'.format(prefix_str))
			print('\t</metadata>')
			print('</single>')
	for j in [0, CLB_Y+IOB_Y*2-1]:
		for i in range(CLB_X+IOB_X*2):
			print('<single priority="{0}" type="{1}" x="{2}" y="{3}">'.format(IOB_PRIORITY, IOB_TYPE, i, j))
			print('\t<metadata>')
			prefix_str = ""
			for c in range(IOB_CAPACITY):
				prefix_str += "{0}_{1}_{2}_{3}".format(IOB_TYPE, i, j, c)
				if c != IOB_CAPACITY-1: prefix_str += " "
			print('\t\t<meta name="fasm_prefix">{0}</meta>'.format(prefix_str))
			print('\t</metadata>')
			print('</single>')
	print('\n'*5)

if opt.clb:
	print('<!-- CLBs -->')
	for i in range(IOB_X, IOB_X+CLB_X):
		for j in range(IOB_Y, IOB_Y+CLB_Y):
			print('<single priority="{0}" type="{1}" x="{2}" y="{3}">'.format(PRIORITY, TYPE, i, j))
			print('\t<metadata>')
			print('\t\t<meta name="fasm_prefix">{0}_{1}_{2}</meta>'.format(TYPE, i, j))
			print('\t</metadata>')
			print('</single>')
	print('\n'*5)

if opt.xbar:
	print('<!-- XBAR MUXs -->')
	inputs = "clb.I4[5] clb.I4[4] clb.I4[3] clb.I4[2] clb.I4[1] clb.I4[0] clb.I3[5] clb.I3[4] clb.I3[3] clb.I3[2] clb.I3[1] clb.I3[0] ble6[2].out_local ble6[1].out_local ble6[0].out_local"
	outputs = "ble6[7].in_A ble6[6].in_A ble6[5].in_A ble6[4].in_A ble6[3].in_A ble6[2].in_A ble6[1].in_A ble6[0].in_A"
	delay_cnst_lines = ['<delay_constant max="152.04e-12" in_port="clb.I4" out_port="ble6.in_A"/>', '<delay_constant max="152.04e-12" in_port="clb.I3" out_port="ble6.in_A"/>']
	inputs_list = inputs.split(' ')
	outputs_list = outputs.split(' ')
	tag = "0"
	def gen_mux():
		print('<!-- {0} -->'.format(tag))
		inputs_list.reverse()
		for i, output in enumerate(outputs_list):
			print('<mux name="{2}" input="{0}" output="{1}">'.format(inputs, output, 'mux_{0}'.format(output)))
			print('\t<metadata>')
			print('\t\t<meta name="fasm_mux">')
			for j, inp in enumerate(inputs_list):
				print('\t\t\t{0} : mux_xbar_{2}_{1}'.format(inp, j, tag))
			print('\t\t</meta>')
			print('\t</metadata>')
			if i==0:
				for inst in delay_cnst_lines:
					print('\t'+inst)
			print('</mux>')
	gen_mux()

	inputs = "clb.I3[5] clb.I3[4] clb.I3[3] clb.I3[2] clb.I3[1] clb.I3[0] clb.I2[5] clb.I2[4] clb.I2[3] clb.I2[2] clb.I2[1] clb.I2[0] ble6[4].out_local ble6[3].out_local ble6[2].out_local"
	outputs = "ble6[7].in_B ble6[6].in_B ble6[5].in_B ble6[4].in_B ble6[3].in_B ble6[2].in_B ble6[1].in_B ble6[0].in_B"
	delay_cnst_lines = ['<delay_constant max="152.04e-12" in_port="clb.I3" out_port="ble6.in_B"/>', '<delay_constant max="152.04e-12" in_port="clb.I2" out_port="ble6.in_B"/>']
	inputs_list = inputs.split(' ')
	outputs_list = outputs.split(' ')
	tag = "1"
	gen_mux()

	inputs = "clb.I2[5] clb.I2[4] clb.I2[3] clb.I2[2] clb.I2[1] clb.I2[0] clb.I1[5] clb.I1[4] clb.I1[3] clb.I1[2] clb.I1[1] clb.I1[0] ble6[6].out_local ble6[5].out_local ble6[4].out_local"
	outputs = "ble6[7].in_C ble6[6].in_C ble6[5].in_C ble6[4].in_C ble6[3].in_C ble6[2].in_C ble6[1].in_C ble6[0].in_C"
	delay_cnst_lines = ['<delay_constant max="152.04e-12" in_port="clb.I2" out_port="ble6.in_C"/>', '<delay_constant max="152.04e-12" in_port="clb.I1" out_port="ble6.in_C"/>']
	inputs_list = inputs.split(' ')
	outputs_list = outputs.split(' ')
	tag = "2"
	gen_mux()

	inputs = "clb.I1[5] clb.I1[4] clb.I1[3] clb.I1[2] clb.I1[1] clb.I1[0] clb.I4[5] clb.I4[4] clb.I4[3] clb.I4[2] clb.I4[1] clb.I4[0] ble6[7].out_local ble6[6].out_local ble6[5].out_local"
	outputs = "ble6[7].in_D ble6[6].in_D ble6[5].in_D ble6[4].in_D ble6[3].in_D ble6[2].in_D ble6[1].in_D ble6[0].in_D"
	delay_cnst_lines = ['<delay_constant max="152.04e-12" in_port="clb.I1" out_port="ble6.in_D"/>', '<delay_constant max="152.04e-12" in_port="clb.I4" out_port="ble6.in_D"/>']
	inputs_list = inputs.split(' ')
	outputs_list = outputs.split(' ')
	tag = "3"
	gen_mux()