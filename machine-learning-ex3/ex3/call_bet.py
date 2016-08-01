def call_bet(amt : float, pot : float, good : float, total : float, left):
	pot_percent = amt / (2 * amt + pot)
	bad = total - good
	win_percent = 1
	for i in (0, left):
		win_percent *= ((bad - i) / (total - i))
	print('Win : %s, pot : %s' % (win_percent, pot_percent))
