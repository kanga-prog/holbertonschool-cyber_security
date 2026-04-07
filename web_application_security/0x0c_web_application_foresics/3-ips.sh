#!/bin/bash
grep -E 'Accepted (password|publickey) for root' $1 | awk '
{
	for (i = 1; i <= NF; i++)
	{
		if ($i == "from")
			print $(i + 1)
	}
}' | sort -u | wc -l
