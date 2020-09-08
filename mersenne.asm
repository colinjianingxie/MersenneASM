#	t9 = counter
#	t8 = temporary address, points to heap 
#	t7 = temporary index that needs to be modified
# 	t6 = temporary value that needs to be modified in heap
# 	t5 = used for temporary constants
#	s0 = used for subroutine jump 1 level

	.data

test1:	.asciiz "Small Prime Tests\n"
test2:	.asciiz "Compress\n"
test3: 	.asciiz "Shift Right Test\n"
test4: 	.asciiz "Shift Left Test\n"
test5:	.asciiz "Compare Big Tests\n"
test6:	.asciiz "Multiply Tests\n"
test7:  .asciiz "Power Tests\n"
test8:	.asciiz "Subtraction Tests \n"
test9:  .asciiz "Modulus Tests \n"
test10: .asciiz "LLT Tests \n"
test11: .asciiz "Mersenne Scan \n"

newline: 	.asciiz "\n"
outputline:	.asciiz  "\n------OUTPUT------\n"
not_prime:	.asciiz " Mp not prime\n"
prime_2:	.asciiz " found prime p=2\n"
found_prime: .asciiz " found prime Mp = "
testing:	.asciiz "Testing p = "


# Small Prime test cases
small_p_1:		.word 7				# small prime test case 1, p = 7
small_p_2:		.word 81			# small prime test case 2, p = 2
small_p_3:		.word 127			# small prime test case 3, p = 127

# Compress Test
compress_a:		.word 3 0 0 0
len_compress_a:	.word 4

# Shift right test cases
shift_right_a:				.word 3
len_shift_right_a:			.word 1

# Shift left test cases
shift_left_a:				.word 0 0 0 7
len_shift_left_a:			.word 4

# Compare Big test cases
a_comp_1:				.word 2 4
b_comp_1:				.word 0 3
len_a_comp_1: 			.word 2
len_b_comp_1:			.word 2

a_comp_2:				.word 0 3
b_comp_2:				.word 2 4
len_a_comp_2: 			.word 2
len_b_comp_2:			.word 2

a_comp_3:				.word 2 4
b_comp_3:				.word 2 4
len_a_comp_3: 			.word 2
len_b_comp_3:			.word 2


# Multiply Big test cases
a_mult_1:				.word 3
b_mult_1:				.word 7
len_a_mult_1:			.word 1
len_b_mult_1:			.word 1

a_mult_2:				.word 0 3
b_mult_2:				.word 2 4
len_a_mult_2:			.word 2
len_b_mult_2:			.word 2

a_mult_3:				.word 0 0 0 0 0 0 0 1
b_mult_3:				.word 0 0 0 0 0 0 9
len_a_mult_3:			.word 8
len_b_mult_3:			.word 7

# Power test cases
a_pow_1:				.word 3
len_a_pow_1:			.word 1
pow_big_t1:				.word 4

a_pow_2:				.word 2 4
len_a_pow_2:			.word 2
pow_big_t2:				.word 42


# Subtraction test cases
a_sub_1:				.word 7
b_sub_1:				.word 3
len_a_sub_1:			.word 1
len_b_sub_1:			.word 1

a_sub_2:				.word 2 4
b_sub_2:				.word 2 1
len_a_sub_2:			.word 2 
len_b_sub_2:			.word 2

a_sub_3:				.word 0 0 0 0 0 0 0 0 0 9
b_sub_3:				.word 1 2 3 4 5 6 7
len_a_sub_3:			.word 10
len_b_sub_3:			.word 7


# Mod test cases
a_mod_1:				.word 7
b_mod_1:				.word 3
len_a_mod_1:			.word 1
len_b_mod_1:			.word 1

a_mod_2:				.word 8 4
b_mod_2:				.word 2 1
len_a_mod_2:			.word 2
len_b_mod_2:			.word 2

a_mod_3:				.word 0 0 0 0 0 0 0 0 0 9
b_mod_3:				.word 1 2 3 4 5 6 7
len_a_mod_3:			.word 10
len_b_mod_3:			.word 7


# LLT Test Cases
llt_1:					.word 11
llt_2:					.word 61

bigint_a:		.word 2
bigint_b:		.word 1
len_max_arr:	.word 350				# LENGTH OF MAX ARRAY

len_a:			.word 1					# LENGTH OF DEFAULT A
len_b:			.word 1					# LENGTH OF DEFAULT B
len_c:			.word 700				# = 2* maxlength (play it safe)


index_a:		.word 0					# index a =  0	
index_len_a:	.word 1400				# index len(a) = index_a + 4 * len_max_arr
index_b:		.word 1404				# index b = 4 + index_len_a  
index_len_b:	.word 2804				# index len(a) = index_b + 4 * len_max_arr
index_c:		.word 2808				# index c = 4 + index_len_b
index_len_c:	.word 5608				# index_len_c = index_c + 8 * len_max_arr
index_temp:		.word 5612				# idnex_temp = 4 + index_len_c
index_len_temp:	 .word 7012				# index_len_temp = len_max_arr * 4 + index_temp
index_prim:		.word 7016				# where prime is located, for recall later
index_limit:	.word 7020				# Where the limit is located, for recall later

heap_size:		.word 7024				# sum 8*(len_max_arr+1) + 4*(2*len_max_arr + 1)

shift_left_case: 	.word 3				# shift left 3 times, can't = max len
small_prime_p:		.word 7				# small prime testing

pow_big_p:			.word 5				# p exponent for powbig
llt_p:			.word 61					# p value for LLT 	# 230, 951

	.text
main:

	##############################
	# INITIALIZE HEAP
	##############################

	jal malloc_heap				# allocate memory into heap
	lw $t0 heap_size			# t0 temporary stores heap size
	jal reset_counter_t9		# reset counter at t9
	jal, init_heap				# Initialize all values to 0




	################################
	#
	# BEGIN SMALL PRIME TESTS
	#
	################################

	la $a0, test1			# Loads space
	li $v0, 4				# print string
	syscall

	# ---------------------
	# IS PRIME, p = 7
	# ---------------------
	li $t9, 2				# start counter at 2
	lw $a2, small_p_1		# small prime p into a2
	addi $a1, $a2, -2		# up to this value
	li $a0, 0				# set to 0 as default
	jal is_small_prime		# perform is small prime
	li $v0, 1				# about to print int
	syscall
	la $a0, newline			# Loads space
	li $v0, 4				# print string
	syscall
	jal reset_all_registers	# reset all registers for next case


	# ---------------------
	# IS PRIME, p = 81
	# ---------------------
	li $t9, 2				# start counter at 2
	lw $a2, small_p_2		# small prime p into a2
	addi $a1, $a2, -2		# up to this value
	li $a0, 0				# set to 0 as default
	jal is_small_prime		# perform is small prime
	li $v0, 1				# about to print int
	syscall
	la $a0, newline			# Loads space
	li $v0, 4				# print string
	syscall
	jal reset_all_registers	# reset all registers for next case


	# ---------------------
	# IS PRIME, p = 127
	# ---------------------
	li $t9, 2				# start counter at 2
	lw $a2, small_p_3		# small prime p into a2
	addi $a1, $a2, -2		# up to this value
	li $a0, 0				# set to 0 as default
	jal is_small_prime		# perform is small prime
	li $v0, 1				# about to print int
	syscall
	la $a0, newline			# Loads space
	li $v0, 4				# print string
	syscall
	jal reset_all_registers	# reset all registers for next case





	############################
	#
	# BEGIN COMPRESS TESTS
	#
	############################

	la $a0, test2			# Loads space
	li $v0, 4				# print string
	syscall


	# COMPRESS, A = 3 0 0 0 (0003 decimal)
	# -------------------------------------


	# INTIIALIZE COMPRESS A
	# -------------------------------------

	# INITIALIZING COMPRESS A
	la $a0, compress_a			# put big int a into a0
	lw $a1, len_compress_a		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF COMPRESS A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH COMPRESS A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# COMPRESS AND STORE LENGTH
	# -------------------------------------

	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_a			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	# End Compress and store length
	# a1 holds the new length
	# -------------------------------------

	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A

	jal print_big				# Print bigint temp

	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall


	# RESETTING A and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0
	jal reset_all_registers		# reset all registers for next case



	############################
	#
	# BEGIN SHIFT RIGHT TESTS
	#
	############################

	la $a0, test3			# Loads space
	li $v0, 4				# print string
	syscall


	# INTIIALIZE SHIFT RIGHT A
	# -------------------------------------

	# INITIALIZING SHIFT RIGHT A
	la $a0, shift_right_a		# put big int a into a0
	lw $a1, len_shift_right_a	# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF SHIFT RIGHT A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH SHIFT RIGHT A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# BEGIN SHIFT RIGHT, shift = 3
	#---------------------------------

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 3					# t6 holds shift value
	jal obtain_shift_offset		# t6 holds shift offset

	lw $t7, index_a				# Start at the length A index
	jal obtain_length_shift_t7	# obtain 4 * length into t7
	addi $a1, $a1, 1			# add 1 to a1, for counter purposes
	jal start_heap_t7			# start heap index at t7 (end of significant big int)
	jal shift_right				# start the shift		


	# END SHIFT RIGHT
	#---------------------------------



	# Compress and store length
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_a			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint A
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	# End Compress and store length
	# a1 holds the new length
	#---------------------------------

	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A

	jal print_big				# Print bigint temp

	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall

	# RESETTING A and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0
	jal reset_all_registers		# reset all registers for next case




	############################
	#
	# BEGIN SHIFT LEFT TESTS
	#
	############################

	la $a0, test4			# Loads space
	li $v0, 4				# print string
	syscall

	# INTIIALIZE SHIFT RIGHT A
	# -------------------------------------

	# INITIALIZING SHIFT RIGHT A
	la $a0, shift_left_a		# put big int a into a0
	lw $a1, len_shift_left_a	# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF SHIFT RIGHT A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH SHIFT RIGHT A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array



	# BEGIN SHIFT LEFT
	# -------------------------------------

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# start at beginning of A in heap
	jal, start_heap_t7			# Start array at 0


	li $t6, 2					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index
	beq $a1, $0, zero_ls_case	# skip rest if zero case

	jal shift_left				# Shifts left
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t6, shift_left_case		# t6 holds shift value
	lw $t7, index_a				# start at beginning of A in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7
	jal fill_shift_left_0		# Fill rest with 0's
	j compress_ls_case			# jump to compress array

zero_ls_case:
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# start at beginning of A in heap
	jal, start_heap_t7			# Start array at 0
	li $t5, 1
	sw $t5, ($t8)				# store 0 in arr

	# END SHIFT LEFT
	# -------------------------------------


	# Compress and store length
	#---------------------------------
compress_ls_case:
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_a			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint A
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	# End Compress and store length
	# a1 holds the new length
	#---------------------------------

	#---------------------------------
	# PRINT THE BIG INT

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A
	jal print_big				# Print bigint temp
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall


	# RESETTING A and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0
	jal reset_all_registers		# reset all registers for next case



	############################
	#
	# BEGIN COMPARE BIG TESTS
	#
	############################

	la $a0, test5			# Loads space
	li $v0, 4				# print string
	syscall

	# -----------------------------
	# COMPARE BIG: A = 42, B = 30
	# -----------------------------

	# INTIIALIZE A
	# ----------------------------------------

	# INITIALIZING parameters A
	la $a0, a_comp_1			# put big int a into a0
	lw $a1, len_a_comp_1		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# INTIIALIZE B
	# ----------------------------------------

	# INITIALIZING parameters B
	la $a0, b_comp_1			# put big int a into a0
	lw $a1, len_b_comp_1		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# COMPARE BIG Case 1
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	li $v0, 1					# print integer
	syscall	
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall


	# -----------------------------
	# COMPARE BIG: A = 30, B = 42
	# -----------------------------

	# INTIIALIZE A
	# ----------------------------------------

	# INITIALIZING A
	la $a0, a_comp_2			# put big int a into a0
	lw $a1, len_a_comp_2		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# INTIIALIZE B
	# ----------------------------------------

	# INITIALIZING B
	la $a0, b_comp_2			# put big int a into a0
	lw $a1, len_b_comp_2		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# COMPARE BIG Case 2
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	li $v0, 1					# print integer
	syscall	
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall


	# -----------------------------
	# COMPARE BIG: A = 30, B = 42
	# -----------------------------

	# INTIIALIZE A
	# ----------------------------------------

	# INITIALIZING A
	la $a0, a_comp_3			# put big int a into a0
	lw $a1, len_a_comp_3		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# INTIIALIZE B
	# ----------------------------------------

	# INITIALIZING B
	la $a0, b_comp_3			# put big int a into a0
	lw $a1, len_b_comp_3		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# COMPARE BIG Case 2
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	li $v0, 1					# print integer
	syscall	
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall


	# RESETTING A,B and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_all_registers		# reset all registers for next case





	############################
	#
	# BEGIN MULTIPLY TESTS
	#
	############################

	la $a0, test5			# Loads space
	li $v0, 4				# print string
	syscall

	# -----------------------------
	# MULTIPLY: A = 3, B = 7
	# -----------------------------

	# INTIIALIZE A
	# ----------------------------------------

	# INITIALIZING A
	la $a0, a_mult_1			# put big int a into a0
	lw $a1, len_a_mult_1		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# INTIIALIZE B
	# ----------------------------------------

	# INITIALIZING B
	la $a0, b_mult_1			# put big int a into a0
	lw $a1, len_b_mult_1		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array



	# GET LENGTH OF A
	# ----------------------------------------

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value

	# GET LENGTH OF B
	# ----------------------------------------
	
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a2, $0, $t6			# a1 = t6 value

	jal reset_counter_t9		# reset counter at t9
	li $t4, 4					# temp constant
								#	a1 = a.n; a2 = b.n; t5 = carry; s1 = j

mult_beg_loop_t1:				# for(int i = 0; i < b.n; i++)
	li $t5, 0					# carry is 0
	add $s1, $t9, $0			# j = i, s1 = j
	add $t0, $a1, $t9			# t0 = a.n + i


	mult $t9, $t4		# 4*i for offset
	mflo $t2			# t2 = 4*i

inner_loop_t1: 			# for(j = i, j< a.n + i; j++)

	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j


	sub $t3, $t1, $t2	# t3 = t1 - t2, t3 = j-i

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	# Get b[i], $s3
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the length B index	
	add $t7, $t7, $t2			# go to index in B
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s3, $0, $t6			# s3 = b[i]

	# Get a[j-i], $s4
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	add $t7, $t7, $t3			# go to index in 
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s4, $0, $t6			# 

	mult $s3, $s4				# b[i] * a[j-i]
	mflo $s5					# s5 is value

	add $s5, $s5, $t5			# add carry
	add $s5, $s5, $s2			# add c[j]


	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4			# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	sw $s4, ($t8)

	addi $s1, $s1, 1			# j += 1
	bne $s1, $t0, inner_loop_t1	# Break otu of loop when j = a.n + i

	ble $t5, $0, continue_outer_for_t1	# if carry <= 0, skip the next statements
	# if not, do the following statements:

	# NEED TO READD THE INDEX

	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	add $s5, $s2, $t5			# val = c[j] + carry
	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4					# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	add $t6, $s4, $0			# t6 = s4
	jal set_val					# store value from t6 into c[j]

continue_outer_for_t1:
	addi $t9, $t9, 1			# increase counter
	bne $t9, $a2, mult_beg_loop_t1	# redo loop if counter i != length


	# Compress and store length for C
	# ----------------------------------------
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	# End Compress and store length
	# a1 holds the new length
	# ----------------------------------------

	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c 			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end_c		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A

	jal print_big				# Print bigint temp
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall

	# RESETTING A,B,C and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case





	# -----------------------------
	# MULTIPLY: A = 30, B = 42
	# -----------------------------

	# INTIIALIZE A
	# ----------------------------------------

	# INITIALIZING A
	la $a0, a_mult_2			# put big int a into a0
	lw $a1, len_a_mult_2		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# INTIIALIZE B
	# ----------------------------------------

	# INITIALIZING B
	la $a0, b_mult_2			# put big int a into a0
	lw $a1, len_b_mult_2		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array

	# GET LENGTH OF A
	# ----------------------------------------

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value

	# GET LENGTH OF B
	# ----------------------------------------
	
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a2, $0, $t6			# a1 = t6 value

	jal reset_counter_t9		# reset counter at t9
	li $t4, 4					# temp constant
								#	a1 = a.n; a2 = b.n; t5 = carry; s1 = j

mult_beg_loop_t2:				# for(int i = 0; i < b.n; i++)
	li $t5, 0					# carry is 0
	add $s1, $t9, $0			# j = i, s1 = j
	add $t0, $a1, $t9			# t0 = a.n + i


	mult $t9, $t4		# 4*i for offset
	mflo $t2			# t2 = 4*i

inner_loop_t2: 			# for(j = i, j< a.n + i; j++)

	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j


	sub $t3, $t1, $t2	# t3 = t1 - t2, t3 = j-i

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	# Get b[i], $s3
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the length B index	
	add $t7, $t7, $t2			# go to index in B
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s3, $0, $t6			# s3 = b[i]

	# Get a[j-i], $s4
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	add $t7, $t7, $t3			# go to index in 
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s4, $0, $t6			# 

	mult $s3, $s4				# b[i] * a[j-i]
	mflo $s5					# s5 is value

	add $s5, $s5, $t5			# add carry
	add $s5, $s5, $s2			# add c[j]


	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4			# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	sw $s4, ($t8)

	addi $s1, $s1, 1						# j += 1
	bne $s1, $t0, inner_loop_t2			# Break otu of loop when j = a.n + i

	ble $t5, $0, continue_outer_for_t2	# if carry <= 0, skip the next statements


	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	add $s5, $s2, $t5			# val = c[j] + carry
	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4					# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	add $t6, $s4, $0			# t6 = s4
	jal set_val					# store value from t6 into c[j]

continue_outer_for_t2:
	addi $t9, $t9, 1			# increase counter
	bne $t9, $a2, mult_beg_loop_t2	# redo loop if counter i != length


	# Compress and store length for C
	# ----------------------------------------
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	# End Compress and store length
	# a1 holds the new length
	# ----------------------------------------

	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c 			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end_c		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A

	jal print_big				# Print bigint temp
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall

	# RESETTING A,B,C and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case





	# ----------------------------------------
	# MULTIPLY: A = 10,000,000 , B = 9,000,000
	# ----------------------------------------

	# INTIIALIZE A
	# ----------------------------------------

	# INITIALIZING A
	la $a0, a_mult_3			# put big int a into a0
	lw $a1, len_a_mult_3		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# INTIIALIZE B
	# ----------------------------------------

	# INITIALIZING B
	la $a0, b_mult_3			# put big int a into a0
	lw $a1, len_b_mult_3		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array

	# GET LENGTH OF A
	# ----------------------------------------

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value

	# GET LENGTH OF B
	# ----------------------------------------
	
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a2, $0, $t6			# a1 = t6 value

	jal reset_counter_t9		# reset counter at t9
	li $t4, 4					# temp constant
								#	a1 = a.n; a2 = b.n; t5 = carry; s1 = j

mult_beg_loop_t3:				# for(int i = 0; i < b.n; i++)
	li $t5, 0					# carry is 0
	add $s1, $t9, $0			# j = i, s1 = j
	add $t0, $a1, $t9			# t0 = a.n + i


	mult $t9, $t4		# 4*i for offset
	mflo $t2			# t2 = 4*i

inner_loop_t3: 			# for(j = i, j< a.n + i; j++)

	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j


	sub $t3, $t1, $t2	# t3 = t1 - t2, t3 = j-i

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	# Get b[i], $s3
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the length B index	
	add $t7, $t7, $t2			# go to index in B
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s3, $0, $t6			# s3 = b[i]

	# Get a[j-i], $s4
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	add $t7, $t7, $t3			# go to index in 
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s4, $0, $t6			# 

	mult $s3, $s4				# b[i] * a[j-i]
	mflo $s5					# s5 is value

	add $s5, $s5, $t5			# add carry
	add $s5, $s5, $s2			# add c[j]


	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4			# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	sw $s4, ($t8)

	addi $s1, $s1, 1						# j += 1
	bne $s1, $t0, inner_loop_t3			# Break otu of loop when j = a.n + i

	ble $t5, $0, continue_outer_for_t3	# if carry <= 0, skip the next statements


	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	add $s5, $s2, $t5			# val = c[j] + carry
	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4					# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	add $t6, $s4, $0			# t6 = s4
	jal set_val					# store value from t6 into c[j]

continue_outer_for_t3:
	addi $t9, $t9, 1			# increase counter
	bne $t9, $a2, mult_beg_loop_t3	# redo loop if counter i != length


	# Compress and store length for C
	# ----------------------------------------
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	# End Compress and store length
	# a1 holds the new length
	# ----------------------------------------

	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c 			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end_c		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A

	jal print_big				# Print bigint temp
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall

	# RESETTING A,B,C and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case


	############################
	#
	# BEGIN POWER TESTS
	#
	############################

	la $a0, test7			# Loads space
	li $v0, 4				# print string
	syscall




	# ----------------------------------------
	# POWER: A = 3 ^ 4
	# ----------------------------------------

	# INTIIALIZE A
	# ----------------------------------------

	# INITIALIZING A
	la $a0, a_pow_1				# put big int a into a0
	lw $a1, len_a_pow_1			# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array

	# Storign A into Temp

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	add $t4, $t8, $0			# t4 = t8
	lw $a1, len_a				# get length of A

	# INITALIZE LENGTH OF TEMP
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal store_a_in_temp			# store A into temp

	li $s6, 1					# s6 will be counter for power loop
	lw $a3, pow_big_t1


	#######################################
	#	Begin for loop
	#######################################

pow_big_for_loop_pt1: 

	############ START MULTIPLICATION #####################


	#### RESETTING C ######
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c



	# GET LENGTH OF temp
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value


	# GET LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a2, $0, $t6			# a2 = t6 value

	jal reset_counter_t9		# reset counter at t9


	#	a1 = temp.n
	#	a2 = a.n
	#	t5 = carry
	#	s1 = j


	li $t4, 4			# temp constant

mult_beg_loop_pt1:					# for(int i = 0; i < b.n; i++)
	li $t5, 0					# carry is 0
	add $s1, $t9, $0			# j = i, s1 = j
	add $t0, $a1, $t9			# t0 = a.n + i


	mul $t2, $t9, $t4		# 4*i for offset
	#mflo $t2				# t2 = 4*i


inner_loop_pt1: 			# for(j = i, j< a.n + i; j++)

	mul $t1, $s1, $t4		# 4*j for offset
	#mflo $t1			# t1 = 4*j


	sub $t3, $t1, $t2	# t3 = t1 - t2, t3 = j-i

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	# Get b[i], $s3
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length B index	
	add $t7, $t7, $t2			# go to index in B
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s3, $0, $t6			# s3 = b[i]

	# Get a[j-i], $s4
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp				# Start at the length A index	
	add $t7, $t7, $t3			# go to index in 
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s4, $0, $t6			# 

	mul $s5, $s3, $s4				# b[i] * a[j-i]

	add $s5, $s5, $t5			# add carry
	add $s5, $s5, $s2			# add c[j]


	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4			# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	sw $s4, ($t8)


	addi $s1, $s1, 1					# j += 1
	bne $s1, $t0, inner_loop_pt1		# Break otu of loop when j = a.n + i
	ble $t5, $0, continue_outer_for_pt1	# if carry <= 0, skip the next statements
										# if not, do the following statements:

	mul $t1, $s1, $t4		# 4*j for offset

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	add $s5, $s2, $t5			# val = c[j] + carry
	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4					# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	add $t6, $s4, $0			# t6 = s4
	jal set_val					# store value from t6 into c[j]




continue_outer_for_pt1:
	addi $t9, $t9, 1			# increase counter
	bne $t9, $a2, mult_beg_loop_pt1	# redo loop if counter i != length

	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	# STORE UPDATED LENGHT OF C INTO TEMP LEN
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)


	#####################################
	# NEED TO STORE VALUES OF C INTO TEMP
	#####################################
	# a1 = lenght of temp
	# t4 = address of c
	# t8 = address of temp

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# modifying index 0
	jal, start_heap_t7			# Start array at 0

	add $t4, $t8, $0			# t4 = t8, ! t4 = address for C

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0

	jal store_c_in_temp			# store A into temp
	addi $s6, $s6, 1				# increment counter

	bne $s6, $a3, pow_big_for_loop_pt1	# reloop



	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A
	jal print_big				# Print bigint temp
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall


	# RESETTING A,B,C,Temp and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case





	# ----------------------------------------
	# POWER: A = 42 ^ 42
	# ----------------------------------------

	# INITIALIZING A
	la $a0, a_pow_2				# put big int a into a0
	lw $a1, len_a_pow_2			# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array



	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0

	add $t4, $t8, $0			# t4 = t8
	lw $a1, len_a_pow_2			# get length of A


	# INITALIZE LENGTH OF TEMP
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0

	jal store_a_in_temp			# store A into temp


	li $s6, 1					# s6 will be counter for power loop

	lw $a3, pow_big_t2



pow_big_for_loop_pt2: 



	#### RESETTING C ######
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c



	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value

	
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a2, $0, $t6			# a2 = t6 value

	jal reset_counter_t9		# reset counter at t9

	li $t4, 4			# temp constant

mult_beg_loop_pt2:					# for(int i = 0; i < b.n; i++)
	li $t5, 0					# carry is 0
	add $s1, $t9, $0			# j = i, s1 = j
	add $t0, $a1, $t9			# t0 = a.n + i


	mul $t2, $t9, $t4		# 4*i for offset
	#mflo $t2			# t2 = 4*i


inner_loop_pt2: 			# for(j = i, j< a.n + i; j++)

	mul $t1, $s1, $t4		# 4*j for offset
	#mflo $t1			# t1 = 4*j


	sub $t3, $t1, $t2	# t3 = t1 - t2, t3 = j-i

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	# Get b[i], $s3
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length B index	
	add $t7, $t7, $t2			# go to index in B
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s3, $0, $t6			# s3 = b[i]

	# Get a[j-i], $s4
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp				# Start at the length A index	
	add $t7, $t7, $t3			# go to index in 
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s4, $0, $t6			# 

	mul $s5, $s3, $s4				# b[i] * a[j-i]

	add $s5, $s5, $t5			# add carry
	add $s5, $s5, $s2			# add c[j]


	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4			# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	sw $s4, ($t8)


	addi $s1, $s1, 1			# j += 1
	bne $s1, $t0, inner_loop_pt2	# Break otu of loop when j = a.n + i




	ble $t5, $0, continue_outer_for_pt2	# if carry <= 0, skip the next statements
	# if not, do the following statements:



	mul $t1, $s1, $t4		# 4*j for offset

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	add $s5, $s2, $t5			# val = c[j] + carry
	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4					# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	add $t6, $s4, $0			# t6 = s4
	jal set_val					# store value from t6 into c[j]




continue_outer_for_pt2:
	addi $t9, $t9, 1			# increase counter
	bne $t9, $a2, mult_beg_loop_pt2	# redo loop if counter i != length



	# Compress and store length for C

	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1



	# STORE UPDATED LENGHT OF C INTO TEMP LEN
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# modifying index 0
	jal, start_heap_t7			# Start array at 0

	add $t4, $t8, $0			# t4 = t8, ! t4 = address for C


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0

	jal store_c_in_temp			# store A into temp
	addi $s6, $s6, 1				# increment counter

	bne $s6, $a3, pow_big_for_loop_pt2	# reloop

	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A
	jal print_big				# Print bigint temp
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall


	# RESETTING A,B,C,Temp and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case



	################################
	#
	# BEGIN SUBTRACTION TESTS
	#
	################################

	la $a0, test8			# Loads space
	li $v0, 4				# print string
	syscall

	# ----------------------------------------
	# Subtraction: 7 - 3
	# ----------------------------------------

	# INTIIALIZE A
	# ----------------------------------------

	# INITIALIZING A
	la $a0, a_sub_1			# put big int a into a0
	lw $a1, len_a_sub_1		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# INTIIALIZE B
	# ----------------------------------------

	# INITIALIZING B
	la $a0, b_sub_1			# put big int a into a0
	lw $a1, len_b_sub_1		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array

	# STORE LENGTH OF C
	lw $a1, len_c				# put value of len array into a1
	lw $a2, len_b_sub_1			# length of total array into a2

	# INITALIZE LENGTH OF C
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# Perform subtract
	#-----------------------

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter
	lw $a1, len_a_sub_1			# put value of len array into a1
	addi $a1, $a1, -1			# subtract len_a - 1
	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract




	# Compress and store length for C
	#----------------------------------------------
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c 			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end_c		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A

	jal print_big				# Print bigint temp
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall

	# RESETTING A,B,C,Temp and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case






	# ----------------------------------------
	# Subtraction: 42 - 12
	# ----------------------------------------

	# INTIIALIZE A
	# ----------------------------------------

	# INITIALIZING A
	la $a0, a_sub_2			# put big int a into a0
	lw $a1, len_a_sub_2		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# INTIIALIZE B
	# ----------------------------------------

	# INITIALIZING B
	la $a0, b_sub_2			# put big int a into a0
	lw $a1, len_b_sub_2		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array

	# STORE LENGTH OF C
	lw $a1, len_c				# put value of len array into a1
	lw $a2, len_b_sub_2			# length of total array into a2

	# INITALIZE LENGTH OF C
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# Perform subtract
	#-----------------------

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter
	lw $a1, len_a_sub_2			# put value of len array into a1
	addi $a1, $a1, -1			# subtract len_a - 1
	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract




	# Compress and store length for C
	#----------------------------------------------
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c 			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end_c		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A

	jal print_big				# Print bigint temp
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall

	# RESETTING A,B,C,Temp and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case






	# ----------------------------------------
	# Subtraction: 9000000000 - 7654321
	# ----------------------------------------

	# INTIIALIZE A
	# ----------------------------------------

	# INITIALIZING A
	la $a0, a_sub_3			# put big int a into a0
	lw $a1, len_a_sub_3		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# INTIIALIZE B
	# ----------------------------------------

	# INITIALIZING B
	la $a0, b_sub_3			# put big int a into a0
	lw $a1, len_b_sub_3		# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array

	# STORE LENGTH OF C
	lw $a1, len_c				# put value of len array into a1
	lw $a2, len_b_sub_3			# length of total array into a2

	# INITALIZE LENGTH OF C
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# Perform subtract
	#-----------------------

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter
	lw $a1, len_a_sub_3			# put value of len array into a1
	addi $a1, $a1, -1			# subtract len_a - 1
	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract




	# Compress and store length for C
	#----------------------------------------------
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c 			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end_c		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A

	jal print_big				# Print bigint temp
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall

	# RESETTING A,B,C,Temp and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case









	################################
	#
	# BEGIN MOD TESTS
	#
	################################

	la $a0, test9			# Loads space
	li $v0, 4				# print string
	syscall


	# ------------------------------
	# MOD TEST: 7 % 3
	# ------------------------------

	# INITIALIZING A
	la $a0, a_mod_1				# put big int a into a0
	lw $a1, len_a_mod_1			# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# INTIIALIZE B
	####################################################

	# INITIALIZING B
	la $a0, b_mod_1				# put big int a into a0
	lw $a1, len_b_mod_1			# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array B


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array


	# CREATE C 
	################################

	# STORE LENGTH OF C
	lw $a1, len_c				# put value of len array into a1
	

	# INITALIZE LENGTH OF C
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# INTIIALIZE OG B
	####################################################

	# INITIALIZING OG B
	la $a0, b_mod_1				# put big int a into a0
	lw $a1, len_b_mod_1			# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array B


	# ITERATING THROUGH B AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index temp
	jal, start_heap_t7			# Start array at temp
	jal, init_arr_val			# Initializes all the words in array



compare_big_a_b_1_mt1:			# while (compare_big(a,b) == 1)

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1

	li $t5, -1									# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_mt1	# go to first_mod_left_shift
	li $t5, 0									# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_mt1	# go to first_mod_left_shift

	# else, perform a right shift on B
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap

	li $t6, 1					# t6 holds shift value
	jal obtain_shift_offset		# t6 holds shift offset

	lw $t7, index_b				# Start at the length B index
	jal obtain_length_shift_t7	# obtain 4 * length into t7
	addi $a1, $a1, 1			# add 1 to a1, for counter purposes
	jal start_heap_t7			# start heap index at t7 (end of significant big int)
	jal shift_right				# start the shift		

	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	# End Compress and store length

	j compare_big_a_b_1_mt1			# jump back to compare_big_1


first_mod_left_shift_b_mt1: 


	# Compress and store length
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1



	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index
	jal shift_left				# Shifts left

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7

	jal fill_shift_left_0		# Fill rest with 0's


	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1



compare_big_b_ogb_n1_mt1:			#  compare_big(b, og_b) != -1

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length B and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length temp and puts in t1

	li $a3, -1					# Assume t0 - t1 is negative
	jal check_lengths_b_temp		# checks length, skips next instruction if =
	jal check_comprehensive_b_temp	# when t0 - t1 = 0

	# END of compare big 1
	# a3 holds -1, 0, 1

	li $t5, -1
	beq $a3, $t5, return_a_mt1 # if compare(b, orig_b) == -1 only return A


	# else continue

compare_big_a_b_n1_mt1:				# compare_big(a,b) != -1

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1

	li $t5, -1		
	beq $a0, $t5, second_mod_shift_left_mt1	# if a0 = -1, go to second shift left

	# else, subtract and continue


	#####################################
	# SUBTRACT
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter
	lw $a1, len_a				# put value of len array into a1
	addi $a1, $a1, -1			# subtract len_a - 1
	lw $a2, len_b				# length of total array into a2

	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract


	# RESETTING A's With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's


	# Filling A values with C result
	###############################

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0

	jal reset_counter_t9		# reset counter at t9
	lw $t3, len_a				# store length of a into t3
	jal store_c_in_a			# Store C values into A


	# UPDATE LENGTH OF A
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_a			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6


	# Updating length of bigint A
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	j compare_big_a_b_n1_mt1	# end Inner while loop
	


second_mod_shift_left_mt1:

	# Compress and store length B
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	
	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index

	beq $a1, $0, zero_case_mt1		# skip rest if zero case

	jal shift_left				# Shifts left
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7
	jal fill_shift_left_0		# Fill rest with 0's
	j compress_2_mt1

zero_case_mt1:
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0
	li $t5, 1
	sw $t5, ($t8)				# store 1 in arr


compress_2_mt1:

	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	j compare_big_b_ogb_n1_mt1	# end outter while loop



return_a_mt1:

	# Compress and store length for C
	#----------------------------------------------
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c 			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end_c		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A

	jal print_big				# Print bigint temp
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall

	# RESETTING A,B,C,Temp and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case








	# ------------------------------
	# MOD TEST: 48 % 12
	# ------------------------------



	####################################################
	# INTIIALIZE A
	####################################################

	# INITIALIZING A
	la $a0, a_mod_2				# put big int a into a0
	lw $a1, len_a_mod_2				# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array

	# ----------------------------------------------------



	####################################################
	# INTIIALIZE B
	####################################################

	# INITIALIZING B
	la $a0, b_mod_2			# put big int a into a0
	lw $a1, len_b_mod_2				# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array B


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array





	#################################
	# CREATE C 
	################################

	# STORE LENGTH OF C
	lw $a1, len_c				# put value of len array into a1
	

	# INITALIZE LENGTH OF C
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A





	####################################
	# 	PERFORMING MOD BIG
	####################################

	####################################################
	# INTIIALIZE OG B
	####################################################

	# INITIALIZING OG B
	la $a0, b_mod_2			# put big int a into a0
	lw $a1, len_b_mod_2				# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array B


	# ITERATING THROUGH B AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index temp
	jal, start_heap_t7			# Start array at temp
	jal, init_arr_val			# Initializes all the words in array



compare_big_a_b_1_mt2:				# while (compare_big(a,b) == 1)

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1

	li $t5, -1								# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_mt2	# go to first_mod_left_shift
	li $t5, 0								# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_mt2	# go to first_mod_left_shift

	# else, perform a right shift on B
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap

	li $t6, 1					# t6 holds shift value
	jal obtain_shift_offset		# t6 holds shift offset

	lw $t7, index_b				# Start at the length B index
	jal obtain_length_shift_t7	# obtain 4 * length into t7
	addi $a1, $a1, 1			# add 1 to a1, for counter purposes
	jal start_heap_t7			# start heap index at t7 (end of significant big int)
	jal shift_right				# start the shift		

	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	# End Compress and store length

	j compare_big_a_b_1_mt2				# jump back to compare_big_1

# END while (compare_big(a,b) == 1)

first_mod_left_shift_b_mt2: 

	###########################################
	# Compress and store length
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	###################################################
	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index
	jal shift_left				# Shifts left

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7

	jal fill_shift_left_0		# Fill rest with 0's


	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	####################
	# END SHIFT LEFT
	####################

compare_big_b_ogb_n1_mt2:			#  compare_big(b, og_b) != -1

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length B and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length temp and puts in t1

	li $a3, -1					# Assume t0 - t1 is negative
	jal check_lengths_b_temp		# checks length, skips next instruction if =
	jal check_comprehensive_b_temp	# when t0 - t1 = 0

	# END of compare big 1
	# a3 holds -1, 0, 1

	li $t5, -1
	beq $a3, $t5, return_a_mt2 # if compare(b, orig_b) == -1 only return A


	# else continue

compare_big_a_b_n1_mt2:				# compare_big(a,b) != -1

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1

	li $t5, -1		
	beq $a0, $t5, second_mod_shift_left_mt2	# if a0 = -1, go to second shift left

	# else, subtract and continue


	#####################################
	# SUBTRACT
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter
	lw $a1, len_a_mod_2				# put value of len array into a1
	addi $a1, $a1, -1			# subtract len_a - 1
	lw $a2, len_b_mod_2				# length of total array into a2

	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract


	###############################
	# RESETTING A's With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	###############################
	# Filling A values with C result
	###############################

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0

	jal reset_counter_t9		# reset counter at t9
	lw $t3, len_a_mod_2				# store length of a into t3
	jal store_c_in_a			# Store C values into A


	###########################################
	# UPDATE LENGTH OF A
	# Compress and store length
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_a			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6



	# Updating length of bigint A
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	j compare_big_a_b_n1_mt2		# end Inner while loop
	


second_mod_shift_left_mt2:
	###########################################
	# Compress and store length B
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################


	###################################################
	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index

	beq $a1, $0, zero_case_mt2		# skip rest if zero case

	jal shift_left				# Shifts left
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7
	jal fill_shift_left_0		# Fill rest with 0's
	j compress_2_mt2

zero_case_mt2:
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0
	li $t5, 1
	sw $t5, ($t8)				# store 1 in arr


compress_2_mt2:
	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	####################
	# END SHIFT LEFT
	####################
	j compare_big_b_ogb_n1_mt2		# end outter while loop


return_a_mt2:

	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c 			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# gets value

	add $a0, $0, $t6			# moves value to a0
	li $v0, 1					# put 1 in v0
	syscall						# syscall

	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall

	# RESETTING A,B,C,Temp and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case



	# ---------------------------------
	# MOD TEST: 9000000000 % 7654321
	# ---------------------------------


	####################################################
	# INTIIALIZE A
	####################################################

	# INITIALIZING A
	la $a0, a_mod_3				# put big int a into a0
	lw $a1, len_a_mod_3				# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array

	# ----------------------------------------------------



	####################################################
	# INTIIALIZE B
	####################################################

	# INITIALIZING B
	la $a0, b_mod_3			# put big int a into a0
	lw $a1, len_b_mod_3				# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array B


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array





	#################################
	# CREATE C 
	################################

	# STORE LENGTH OF C
	lw $a1, len_c				# put value of len array into a1
	

	# INITALIZE LENGTH OF C
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A





	####################################
	# 	PERFORMING MOD BIG
	####################################

	####################################################
	# INTIIALIZE OG B
	####################################################

	# INITIALIZING OG B
	la $a0, b_mod_3			# put big int a into a0
	lw $a1, len_b_mod_3				# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array B


	# ITERATING THROUGH B AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index temp
	jal, start_heap_t7			# Start array at temp
	jal, init_arr_val			# Initializes all the words in array



compare_big_a_b_1_mt3:				# while (compare_big(a,b) == 1)

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1

	li $t5, -1								# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_mt3	# go to first_mod_left_shift
	li $t5, 0								# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_mt3	# go to first_mod_left_shift

	# else, perform a right shift on B
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap

	li $t6, 1					# t6 holds shift value
	jal obtain_shift_offset		# t6 holds shift offset

	lw $t7, index_b				# Start at the length B index
	jal obtain_length_shift_t7	# obtain 4 * length into t7
	addi $a1, $a1, 1			# add 1 to a1, for counter purposes
	jal start_heap_t7			# start heap index at t7 (end of significant big int)
	jal shift_right				# start the shift		

	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	# End Compress and store length

	j compare_big_a_b_1_mt3				# jump back to compare_big_1

# END while (compare_big(a,b) == 1)

first_mod_left_shift_b_mt3: 

	###########################################
	# Compress and store length
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	###################################################
	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index
	jal shift_left				# Shifts left

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7

	jal fill_shift_left_0		# Fill rest with 0's


	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	####################
	# END SHIFT LEFT
	####################

compare_big_b_ogb_n1_mt3:			#  compare_big(b, og_b) != -1

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length B and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length temp and puts in t1

	li $a3, -1					# Assume t0 - t1 is negative
	jal check_lengths_b_temp		# checks length, skips next instruction if =
	jal check_comprehensive_b_temp	# when t0 - t1 = 0

	# END of compare big 1
	# a3 holds -1, 0, 1

	li $t5, -1
	beq $a3, $t5, return_a_mt3 # if compare(b, orig_b) == -1 only return A


	# else continue

compare_big_a_b_n1_mt3:				# compare_big(a,b) != -1

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1

	li $t5, -1		
	beq $a0, $t5, second_mod_shift_left_mt3	# if a0 = -1, go to second shift left

	# else, subtract and continue


	#####################################
	# SUBTRACT
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter
	lw $a1, len_a_mod_3				# put value of len array into a1
	addi $a1, $a1, -1			# subtract len_a - 1
	lw $a2, len_b_mod_3				# length of total array into a2

	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract


	###############################
	# RESETTING A's With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	###############################
	# Filling A values with C result
	###############################

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0

	jal reset_counter_t9		# reset counter at t9
	lw $t3, len_a_mod_3				# store length of a into t3
	jal store_c_in_a			# Store C values into A


	###########################################
	# UPDATE LENGTH OF A
	# Compress and store length
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_a			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6



	# Updating length of bigint A
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	j compare_big_a_b_n1_mt3		# end Inner while loop
	


second_mod_shift_left_mt3:
	###########################################
	# Compress and store length B
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################


	###################################################
	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index

	beq $a1, $0, zero_case_mt3		# skip rest if zero case

	jal shift_left				# Shifts left
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7
	jal fill_shift_left_0		# Fill rest with 0's
	j compress_2_mt3

zero_case_mt3:
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0
	li $t5, 1
	sw $t5, ($t8)				# store 1 in arr


compress_2_mt3:
	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	####################
	# END SHIFT LEFT
	####################
	j compare_big_b_ogb_n1_mt3		# end outter while loop



return_a_mt3:

	# Compress and store length for C
	#----------------------------------------------
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	# PRINT THE BIG INT
	#---------------------------------
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c 			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end_c		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A

	jal print_big				# Print bigint temp
	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall

	# RESETTING A,B,C,Temp and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case


	################################
	#
	# BEGIN LLT TESTS
	#
	################################

	la $a0, test10 			# Loads space
	li $v0, 4				# print string
	syscall


	#
	# LLT Test: p = 11
	#-----------------------------------



	# INTIIALIZE A
	####################################################

	# INITIALIZING A
	la $a0, bigint_a			# put big int a into a0
	lw $a1, len_a				# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array

	# ----------------------------------------------------	


	################################
	#	START LLT
	################################

	# INTIIALIZE B (constant Big Int)
	####################################################

	# INITIALIZING B
	la $a0, bigint_b			# put big int a into a0
	lw $a1, len_b				# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array



	#######################################
	#	Performing temp = a;
	#######################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0

	add $t4, $t8, $0			# t4 = t8
	lw $a1, len_a				# get length of A


	# INITALIZE LENGTH OF TEMP
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0

	jal store_a_in_temp			# store A into temp


	li $s6, 1					# s6 will be counter for power loop

	lw $a3, llt_1



pow_big_for_loop_llt_lt1: 


	#### RESETTING C ######
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c



	########################################################
	# GET LENGTH OF temp
	########################################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value




	########################################################
	# GET LENGTH OF A
	########################################################
	
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a2, $0, $t6			# a2 = t6 value

	jal reset_counter_t9		# reset counter at t9


	#	a1 = temp.n
	#	a2 = a.n
	#	t5 = carry
	#	s1 = j


	li $t4, 4			# temp constant

mult_beg_loop_lt1:					# for(int i = 0; i < b.n; i++)
	li $t5, 0					# carry is 0
	add $s1, $t9, $0			# j = i, s1 = j
	add $t0, $a1, $t9			# t0 = a.n + i


	mul $t2, $t9, $t4		# 4*i for offset
	#mflo $t2			# t2 = 4*i


inner_loop_lt1: 			# for(j = i, j< a.n + i; j++)

	mul $t1, $s1, $t4		# 4*j for offset
	#mflo $t1			# t1 = 4*j


	sub $t3, $t1, $t2	# t3 = t1 - t2, t3 = j-i

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	# Get b[i], $s3
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length B index	
	add $t7, $t7, $t2			# go to index in B
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s3, $0, $t6			# s3 = b[i]

	# Get a[j-i], $s4
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp				# Start at the length A index	
	add $t7, $t7, $t3			# go to index in 
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s4, $0, $t6			# 

	mul $s5, $s3, $s4				# b[i] * a[j-i]

	add $s5, $s5, $t5			# add carry
	add $s5, $s5, $s2			# add c[j]


	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4			# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	sw $s4, ($t8)


	addi $s1, $s1, 1			# j += 1
	bne $s1, $t0, inner_loop_lt1	# Break otu of loop when j = a.n + i




	ble $t5, $0, continue_outer_for_lt1	# if carry <= 0, skip the next statements
	# if not, do the following statements:



	mul $t1, $s1, $t4		# 4*j for offset

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	add $s5, $s2, $t5			# val = c[j] + carry
	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4					# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	add $t6, $s4, $0			# t6 = s4
	jal set_val					# store value from t6 into c[j]




continue_outer_for_lt1:
	addi $t9, $t9, 1			# increase counter
	bne $t9, $a2, mult_beg_loop_lt1	# redo loop if counter i != length

	############# END MULTIPLICAITION ##################





	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	# STORE UPDATED LENGHT OF C INTO TEMP LEN
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)


	#####################################
	# NEED TO STORE VALUES OF C INTO TEMP
	#####################################
	# a1 = lenght of temp
	# t4 = address of c
	# t8 = address of temp

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# modifying index 0
	jal, start_heap_t7			# Start array at 0

	add $t4, $t8, $0			# t4 = t8, ! t4 = address for C


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0

	jal store_c_in_temp			# store A into temp



	addi $s6, $s6, 1				# increment counter
	bne $s6, $a3, pow_big_for_loop_llt_lt1	# reloop




	########## POW_BIG(two,p) COMPLETE #################
	# TEMP and C both hold pow_big() #########
	# B HOLDS big_int(1)

	################################
	# subtraction of sub_big(MP, one)
	################################

	#######################
	#### RESETTING C ######
	#######################
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c


	#####################################
	# SUBTRACT (temp - B) = MP - 1
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter
	
	########################################################
	# GET LENGTH OF temp # a1 needs length of top big_int
	########################################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value
	addi $a1, $a1, -1			# subtract len_a - 1
	# a1 = len(a) a2 holds len_b

	jal subtract				# Call subtract

	##########################################
	# BEGIN STORING C into TEMP
	###########################################

	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	# STORE UPDATED LENGHT OF C INTO TEMP LEN
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)


	#####################################
	# NEED TO STORE VALUES OF C INTO TEMP
	#####################################
	# a1 = lenght of temp
	# t4 = address of c
	# t8 = address of temp

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# modifying index 0
	jal, start_heap_t7			# Start array at 0

	add $t4, $t8, $0			# t4 = t8, ! t4 = address for C


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0

	jal store_c_in_temp			# store A into temp

	##########################################
	# END STORING C into TEMP, finished subtract(MP,1)
	###########################################





	###########################################
	# Change A to big_int(4)
	##########################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 4					# Set length of array A
	sw $t0, ($t8)				# stores first element as 4

	##########################################
	# FOR LOOP FOR LLT
	##########################################

	li $s7, 0
	lw $v1, llt_1				# put llt p into a3
	addi $v1, $v1, -2			# limit of the loop


llt_for_lt1:



	###########################################
	# Change B to big_int(2), used in FOR loop
	##########################################

	###############################
	# RESETTING B's With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 2					# Set length of array A
	sw $t0, ($t8)				# stores first element as 4



	######################################
	# mult_big(s,s), A = s
	######################################


	#### RESETTING C ######
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c



	########################################################
	# GET LENGTH OF A
	########################################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value
	add $a2, $0, $t6			# a2 = t6 value (B's length)



	jal reset_counter_t9		# reset counter at t9
	li $t4, 4			# temp constant

llt_mult_beg_loop_lt1:					# for(int i = 0; i < b.n; i++)
	li $t5, 0					# carry is 0
	add $s1, $t9, $0			# j = i, s1 = j
	add $t0, $a1, $t9			# t0 = a.n + i

	mult $t9, $t4		# 4*i for offset
	mflo $t2			# t2 = 4*i

llt_inner_loop_lt1: 			# for(j = i, j< a.n + i; j++)

	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j

	sub $t3, $t1, $t2	# t3 = t1 - t2, t3 = j-i

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	# Get b[i], $s3
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length B index	
	add $t7, $t7, $t2			# go to index in B
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s3, $0, $t6			# s3 = b[i]

	# Get a[j-i], $s4
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	add $t7, $t7, $t3			# go to index in 
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s4, $0, $t6			# 

	mult $s3, $s4				# b[i] * a[j-i]
	mflo $s5					# s5 is value

	add $s5, $s5, $t5			# add carry
	add $s5, $s5, $s2			# add c[j]


	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4			# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	sw $s4, ($t8)

	addi $s1, $s1, 1			# j += 1
	bne $s1, $t0, llt_inner_loop_lt1	# Break otu of loop when j = a.n + i

	ble $t5, $0, llt_continue_outer_for_lt1	# if carry <= 0, skip the next statements
	# if not, do the following statements:

	# NEED TO READD THE INDEX

	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	add $s5, $s2, $t5			# val = c[j] + carry
	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4					# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	add $t6, $s4, $0			# t6 = s4
	jal set_val					# store value from t6 into c[j]



llt_continue_outer_for_lt1:
	addi $t9, $t9, 1			# increase counter
	bne $t9, $a2, llt_mult_beg_loop_lt1	# redo loop if counter i != length



	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################
	
	# Store a1 into len A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)				# store new length into A

	###########################################
	# BEGIN STORE C IN A
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0

	jal reset_counter_t9		# reset counter at t9
	add $t3, $a1, $0			# store length of new C into t3
	jal store_c_in_a			# Store C values into A

	######################
	# END STORE C IN A
	######################



	#######################
	#### RESETTING C ######
	#######################
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c
	########################



	#####################################
	# SUBTRACT
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	

	li $t9, -1					# store -1 as counter
	addi $a1, $a1, -1			# subtract len_a - 1
	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract




	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	#
	# Store a1 into len A
	#############################################
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)				# store new length into A



	###########################################
	# BEGIN STORE C IN A
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0



	jal reset_counter_t9		# reset counter at t9
	lw	$t3, len_max_arr		# store length of new C into t3

	jal store_c_in_a			# Store C values into A

	######################
	# END STORE C IN A
	######################




	#### AT THIS POINT: s = s*s - 2
	#### Need to do: s mod MP now....




	#######################
	#### RESETTING C ######
	#######################
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c
	########################




	#####################
	# TEMP = OG_B
	# B needs to be TEMP
	#####################


	###########################################
	# BEGIN STORE TEMP IN B
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6

	# STore length of B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $t6, ($t8)				# store t6 into t8

	jal reset_counter_t9		# reset counter at t9
	jal store_temp_in_b			# Store C values into A

	###########################################
	# END STORE TEMP IN B
	###########################################



	####################################
	# 	PERFORMING MOD BIG
	####################################



compare_big_a_b_1_lt1:				# while (compare_big(a,b) == 1)

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1



	li $t5, -1								# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_lt1	# go to first_mod_left_shift
	li $t5, 0								# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_lt1	# go to first_mod_left_shift

	##################################
	# else, perform a right shift on B
	##################################
	# SOMETHING WRONG HERE, NEED TO FIGURE OUT LENGTHS

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap

	li $t6, 1					# t6 holds shift value
	jal obtain_shift_offset		# t6 holds shift offset

	lw $t7, index_b				# Start at the length B index
	jal obtain_length_shift_t7	# obtain 4 * length into t7
	addi $a1, $a1, 1			# add 1 to a1, for counter purposes
	jal start_heap_t7			# start heap index at t7 (end of significant big int)
	jal shift_right				# start the shift		

	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	# End Compress and store length



	j compare_big_a_b_1_lt1			# jump back to compare_big_1





# END while (compare_big(a,b) == 1)

first_mod_left_shift_b_lt1: 

	


	###########################################
	# Compress and store length
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################




	###################################################
	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index
	jal shift_left				# Shifts left

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7

	jal fill_shift_left_0		# Fill rest with 0's


	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	####################
	# END SHIFT LEFT
	####################



compare_big_b_ogb_n1_lt1:			#  compare_big(b, og_b) != -1



	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length B and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length temp and puts in t1

	li $a3, -1					# Assume t0 - t1 is negative
	jal check_lengths_b_temp		# checks length, skips next instruction if =
	jal check_comprehensive_b_temp	# when t0 - t1 = 0

	# END of compare big 1
	# a3 holds -1, 0, 1


	li $t5, -1
	beq $a3, $t5, continue_loop_llt_lt1 # if compare(b, orig_b) == -1 only return A
	


	# else continue

compare_big_a_b_n1_lt1:				# compare_big(a,b) != -1



	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1



	li $t5, -1		
	beq $a0, $t5, second_mod_shift_left_lt1	# if a0 = -1, go to second shift left

	# else, subtract and continue






	#####################################
	# SUBTRACT
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter

	# GET UPDATED LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	add $a1, $t6, $0
	addi $a1, $a1, -1			# subtract len_a - 1



	# GET UPDATED LENGTH OF B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b 		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	add $a2, $t6, $0


	# SOMETHING WRONG WITH SUBTRACTION, GETTING WRONG LENGTHS PROBABLY
	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract



	###############################
	# RESETTING A's With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's



	###############################
	# Filling A values with C result
	###############################

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# gets the length
	add $t3, $0, $t6			# store t6 into t3
	jal store_c_in_a			# Store C values into A



	###########################################
	# UPDATE LENGTH OF A
	# Compress and store length
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_a			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6



	# Updating length of bigint A
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	j continue_a_b_n1_lt1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################


continue_a_b_n1_lt1:

	j compare_big_a_b_n1_lt1		# end Inner while loop
	


second_mod_shift_left_lt1:
	###########################################
	# Compress and store length B
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################





	###################################################
	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index

	beq $a1, $0, zero_case_lt1		# skip rest if zero case

	jal shift_left				# Shifts left
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7
	jal fill_shift_left_0		# Fill rest with 0's
	j compress_2_lt1

zero_case_lt1:
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0
	li $t5, 1
	sw $t5, ($t8)				# store 1 in arr


compress_2_lt1:
	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	####################
	# END SHIFT LEFT
	####################



	j compare_big_b_ogb_n1_lt1		# end outter while loop

	################ END BIG MOD ###################


continue_loop_llt_lt1:

	addi $s7, $s7, 1			# increment t9 counter
	bne $s7, $v1, llt_for_lt1		# keep looping until max p hit

	############################
	# END OF OUTER FOR LOOP
	# At this point, s = (s*s)-2 mod mp
	# Where A represents s
	############################


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# start at beginning of A in heap
	jal, start_heap_t7			# start heap index at t7
	jal check_all_zeros			# checks array for all 0

	# t9 holds number of zeros
	lw $t3, len_max_arr		# t3 holds len of max arr

	li $a1, 1					
	beq $t9, $t3, print_lt1	# if t9 = t3, num of 0's  = len of arr, skip

	li $a1, 0	# else = 0

print_lt1:

	add $a0, $a1, $0			# store output into a0
	li $v0, 1					# printing output
	syscall
	la $a0, newline			# Loads space
	li $v0, 4				# print string
	syscall

	# RESETTING A,B,C,Temp and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case





	# 
	# LLT Test p = 61
	# --------------------------------------------------
	# INTIIALIZE A
	####################################################

	# INITIALIZING A
	la $a0, bigint_a			# put big int a into a0
	lw $a1, len_a				# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array

	# ----------------------------------------------------	


	################################
	#	START LLT
	################################

	# INTIIALIZE B (constant Big Int)
	####################################################

	# INITIALIZING B
	la $a0, bigint_b			# put big int a into a0
	lw $a1, len_b				# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array



	#######################################
	#	Performing temp = a;
	#######################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0

	add $t4, $t8, $0			# t4 = t8
	lw $a1, len_a				# get length of A


	# INITALIZE LENGTH OF TEMP
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0

	jal store_a_in_temp			# store A into temp


	li $s6, 1					# s6 will be counter for power loop

	lw $a3, llt_2



pow_big_for_loop_llt_lt2: 


	#### RESETTING C ######
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c



	########################################################
	# GET LENGTH OF temp
	########################################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value




	########################################################
	# GET LENGTH OF A
	########################################################
	
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a2, $0, $t6			# a2 = t6 value

	jal reset_counter_t9		# reset counter at t9


	#	a1 = temp.n
	#	a2 = a.n
	#	t5 = carry
	#	s1 = j


	li $t4, 4			# temp constant

mult_beg_loop_lt2:					# for(int i = 0; i < b.n; i++)
	li $t5, 0					# carry is 0
	add $s1, $t9, $0			# j = i, s1 = j
	add $t0, $a1, $t9			# t0 = a.n + i


	mul $t2, $t9, $t4		# 4*i for offset
	#mflo $t2			# t2 = 4*i


inner_loop_lt2: 			# for(j = i, j< a.n + i; j++)

	mul $t1, $s1, $t4		# 4*j for offset
	#mflo $t1			# t1 = 4*j


	sub $t3, $t1, $t2	# t3 = t1 - t2, t3 = j-i

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	# Get b[i], $s3
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length B index	
	add $t7, $t7, $t2			# go to index in B
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s3, $0, $t6			# s3 = b[i]

	# Get a[j-i], $s4
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp				# Start at the length A index	
	add $t7, $t7, $t3			# go to index in 
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s4, $0, $t6			# 

	mul $s5, $s3, $s4				# b[i] * a[j-i]

	add $s5, $s5, $t5			# add carry
	add $s5, $s5, $s2			# add c[j]


	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4			# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	sw $s4, ($t8)


	addi $s1, $s1, 1			# j += 1
	bne $s1, $t0, inner_loop_lt2	# Break otu of loop when j = a.n + i




	ble $t5, $0, continue_outer_for_lt2	# if carry <= 0, skip the next statements
	# if not, do the following statements:



	mul $t1, $s1, $t4		# 4*j for offset

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	add $s5, $s2, $t5			# val = c[j] + carry
	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4					# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	add $t6, $s4, $0			# t6 = s4
	jal set_val					# store value from t6 into c[j]




continue_outer_for_lt2:
	addi $t9, $t9, 1			# increase counter
	bne $t9, $a2, mult_beg_loop_lt2	# redo loop if counter i != length

	############# END MULTIPLICAITION ##################





	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	# STORE UPDATED LENGHT OF C INTO TEMP LEN
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)


	#####################################
	# NEED TO STORE VALUES OF C INTO TEMP
	#####################################
	# a1 = lenght of temp
	# t4 = address of c
	# t8 = address of temp

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# modifying index 0
	jal, start_heap_t7			# Start array at 0

	add $t4, $t8, $0			# t4 = t8, ! t4 = address for C


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0

	jal store_c_in_temp			# store A into temp



	addi $s6, $s6, 1				# increment counter
	bne $s6, $a3, pow_big_for_loop_llt_lt2	# reloop




	########## POW_BIG(two,p) COMPLETE #################
	# TEMP and C both hold pow_big() #########
	# B HOLDS big_int(1)

	################################
	# subtraction of sub_big(MP, one)
	################################

	#######################
	#### RESETTING C ######
	#######################
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c


	#####################################
	# SUBTRACT (temp - B) = MP - 1
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter
	
	########################################################
	# GET LENGTH OF temp # a1 needs length of top big_int
	########################################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value
	addi $a1, $a1, -1			# subtract len_a - 1
	# a1 = len(a) a2 holds len_b

	jal subtract				# Call subtract

	##########################################
	# BEGIN STORING C into TEMP
	###########################################

	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	# STORE UPDATED LENGHT OF C INTO TEMP LEN
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)


	#####################################
	# NEED TO STORE VALUES OF C INTO TEMP
	#####################################
	# a1 = lenght of temp
	# t4 = address of c
	# t8 = address of temp

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# modifying index 0
	jal, start_heap_t7			# Start array at 0

	add $t4, $t8, $0			# t4 = t8, ! t4 = address for C


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0

	jal store_c_in_temp			# store A into temp

	##########################################
	# END STORING C into TEMP, finished subtract(MP,1)
	###########################################





	###########################################
	# Change A to big_int(4)
	##########################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 4					# Set length of array A
	sw $t0, ($t8)				# stores first element as 4

	##########################################
	# FOR LOOP FOR LLT
	##########################################

	li $s7, 0
	lw $v1, llt_2				# put llt p into a3
	addi $v1, $v1, -2			# limit of the loop


llt_for_lt2:



	###########################################
	# Change B to big_int(2), used in FOR loop
	##########################################

	###############################
	# RESETTING B's With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 2					# Set length of array A
	sw $t0, ($t8)				# stores first element as 4



	######################################
	# mult_big(s,s), A = s
	######################################


	#### RESETTING C ######
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c



	########################################################
	# GET LENGTH OF A
	########################################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value
	add $a2, $0, $t6			# a2 = t6 value (B's length)



	jal reset_counter_t9		# reset counter at t9
	li $t4, 4			# temp constant

llt_mult_beg_loop_lt2:					# for(int i = 0; i < b.n; i++)
	li $t5, 0					# carry is 0
	add $s1, $t9, $0			# j = i, s1 = j
	add $t0, $a1, $t9			# t0 = a.n + i

	mult $t9, $t4		# 4*i for offset
	mflo $t2			# t2 = 4*i

llt_inner_loop_lt2: 			# for(j = i, j< a.n + i; j++)

	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j

	sub $t3, $t1, $t2	# t3 = t1 - t2, t3 = j-i

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	# Get b[i], $s3
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length B index	
	add $t7, $t7, $t2			# go to index in B
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s3, $0, $t6			# s3 = b[i]

	# Get a[j-i], $s4
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	add $t7, $t7, $t3			# go to index in 
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s4, $0, $t6			# 

	mult $s3, $s4				# b[i] * a[j-i]
	mflo $s5					# s5 is value

	add $s5, $s5, $t5			# add carry
	add $s5, $s5, $s2			# add c[j]


	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4			# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	sw $s4, ($t8)

	addi $s1, $s1, 1			# j += 1
	bne $s1, $t0, llt_inner_loop_lt2	# Break otu of loop when j = a.n + i

	ble $t5, $0, llt_continue_outer_for_lt2	# if carry <= 0, skip the next statements
	# if not, do the following statements:

	# NEED TO READD THE INDEX

	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	add $s5, $s2, $t5			# val = c[j] + carry
	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4					# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	add $t6, $s4, $0			# t6 = s4
	jal set_val					# store value from t6 into c[j]



llt_continue_outer_for_lt2:
	addi $t9, $t9, 1			# increase counter
	bne $t9, $a2, llt_mult_beg_loop_lt2	# redo loop if counter i != length



	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################
	
	# Store a1 into len A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)				# store new length into A

	###########################################
	# BEGIN STORE C IN A
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0

	jal reset_counter_t9		# reset counter at t9
	add $t3, $a1, $0			# store length of new C into t3
	jal store_c_in_a			# Store C values into A

	######################
	# END STORE C IN A
	######################



	#######################
	#### RESETTING C ######
	#######################
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c
	########################



	#####################################
	# SUBTRACT
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	

	li $t9, -1					# store -1 as counter
	addi $a1, $a1, -1			# subtract len_a - 1
	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract




	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	#
	# Store a1 into len A
	#############################################
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)				# store new length into A



	###########################################
	# BEGIN STORE C IN A
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0



	jal reset_counter_t9		# reset counter at t9
	lw	$t3, len_max_arr		# store length of new C into t3

	jal store_c_in_a			# Store C values into A

	######################
	# END STORE C IN A
	######################




	#### AT THIS POINT: s = s*s - 2
	#### Need to do: s mod MP now....




	#######################
	#### RESETTING C ######
	#######################
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c
	########################




	#####################
	# TEMP = OG_B
	# B needs to be TEMP
	#####################


	###########################################
	# BEGIN STORE TEMP IN B
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6

	# STore length of B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $t6, ($t8)				# store t6 into t8

	jal reset_counter_t9		# reset counter at t9
	jal store_temp_in_b			# Store C values into A

	###########################################
	# END STORE TEMP IN B
	###########################################



	####################################
	# 	PERFORMING MOD BIG
	####################################



compare_big_a_b_1_lt2:				# while (compare_big(a,b) == 1)

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1



	li $t5, -1								# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_lt2	# go to first_mod_left_shift
	li $t5, 0								# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_lt2	# go to first_mod_left_shift

	##################################
	# else, perform a right shift on B
	##################################
	# SOMETHING WRONG HERE, NEED TO FIGURE OUT LENGTHS

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap

	li $t6, 1					# t6 holds shift value
	jal obtain_shift_offset		# t6 holds shift offset

	lw $t7, index_b				# Start at the length B index
	jal obtain_length_shift_t7	# obtain 4 * length into t7
	addi $a1, $a1, 1			# add 1 to a1, for counter purposes
	jal start_heap_t7			# start heap index at t7 (end of significant big int)
	jal shift_right				# start the shift		

	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	# End Compress and store length



	j compare_big_a_b_1_lt2			# jump back to compare_big_1





# END while (compare_big(a,b) == 1)

first_mod_left_shift_b_lt2: 

	


	###########################################
	# Compress and store length
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################




	###################################################
	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index
	jal shift_left				# Shifts left

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7

	jal fill_shift_left_0		# Fill rest with 0's


	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	####################
	# END SHIFT LEFT
	####################



compare_big_b_ogb_n1_lt2:			#  compare_big(b, og_b) != -1



	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length B and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length temp and puts in t1

	li $a3, -1					# Assume t0 - t1 is negative
	jal check_lengths_b_temp		# checks length, skips next instruction if =
	jal check_comprehensive_b_temp	# when t0 - t1 = 0

	# END of compare big 1
	# a3 holds -1, 0, 1


	li $t5, -1
	beq $a3, $t5, continue_loop_llt_lt2 # if compare(b, orig_b) == -1 only return A
	


	# else continue

compare_big_a_b_n1_lt2:				# compare_big(a,b) != -1



	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1



	li $t5, -1		
	beq $a0, $t5, second_mod_shift_left_lt2	# if a0 = -1, go to second shift left

	# else, subtract and continue






	#####################################
	# SUBTRACT
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter

	# GET UPDATED LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	add $a1, $t6, $0
	addi $a1, $a1, -1			# subtract len_a - 1



	# GET UPDATED LENGTH OF B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b 		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	add $a2, $t6, $0


	# SOMETHING WRONG WITH SUBTRACTION, GETTING WRONG LENGTHS PROBABLY
	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract



	###############################
	# RESETTING A's With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's



	###############################
	# Filling A values with C result
	###############################

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# gets the length
	add $t3, $0, $t6			# store t6 into t3
	jal store_c_in_a			# Store C values into A



	###########################################
	# UPDATE LENGTH OF A
	# Compress and store length
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_a			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6



	# Updating length of bigint A
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	j continue_a_b_n1_lt2


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################


continue_a_b_n1_lt2:

	j compare_big_a_b_n1_lt2		# end Inner while loop
	


second_mod_shift_left_lt2:
	###########################################
	# Compress and store length B
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################





	###################################################
	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index

	beq $a1, $0, zero_case_lt2		# skip rest if zero case

	jal shift_left				# Shifts left
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7
	jal fill_shift_left_0		# Fill rest with 0's
	j compress_2_lt2

zero_case_lt2:
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0
	li $t5, 1
	sw $t5, ($t8)				# store 1 in arr


compress_2_lt2:
	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	####################
	# END SHIFT LEFT
	####################



	j compare_big_b_ogb_n1_lt2		# end outter while loop

	################ END BIG MOD ###################


continue_loop_llt_lt2:

	addi $s7, $s7, 1			# increment t9 counter
	bne $s7, $v1, llt_for_lt2		# keep looping until max p hit

	############################
	# END OF OUTER FOR LOOP
	# At this point, s = (s*s)-2 mod mp
	# Where A represents s
	############################


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# start at beginning of A in heap
	jal, start_heap_t7			# start heap index at t7
	jal check_all_zeros			# checks array for all 0

	# t9 holds number of zeros
	lw $t3, len_max_arr		# t3 holds len of max arr

	li $a1, 1					
	beq $t9, $t3, print_lt2	# if t9 = t3, num of 0's  = len of arr, skip

	li $a1, 0	# else = 0

print_lt2:
	add $a0, $a1, $0			# store output into a0
	li $v0, 1					# printing output
	syscall
	la $a0, newline			# Loads space
	li $v0, 4				# print string
	syscall


	# RESETTING A,B,C,Temp and registers for next test
	# ----------------------------------------
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 0					# Set length of array A
	sw $t0, ($t8)				# stores first element as 0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c

	jal reset_all_registers		# reset all registers for next case


	################################
	# MERSENNE SCAN
	# 
	# performing from 3 -> 127
	#################################


	la $a0, test11			# Loads space
	li $v0, 4				# print string
	syscall
	####################################################
	# INTIIALIZE A
	####################################################

	# INITIALIZING A
	la $a0, bigint_a			# put big int a into a0
	lw $a1, len_a				# put value of len array into a1
	lw $a2, len_max_arr			# length of total array into a2


	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# ITERATING THROUGH A AND STORING INTO HEAP
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal, init_arr_val			# Initializes all the words in array

	# ----------------------------------------------------	



	###############################
	# MERSENNE !start
	###############################


	li $a3, 3					# MODIFY START HERE!!!


begin_mersenne_for_m:
	##########################################
	# Storing a3 as counter for later recall
	##########################################
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_prim			# modifying index_prim
	jal, start_heap_t7			# Start array at index
	sw $a3, ($t8)



	##########################################
	# Storing limit for later recall
	##########################################
	li $t5, 129					# last index FOR RANGE
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_limit			# modifying index_prim
	jal, start_heap_t7			# Start array at index
	sw $t5, ($t8)


	##############################################
	# START IS SMALL PRIME
	##############################################
	li $t9, 2				# start counter at 2
	add $a2, $0, $a3		# smal prime p into a2
	addi $a1, $a2, -2		# up to this value

	li $t5, 2				# test for 3 as limit
	li $a0, 1				# load 1 as default
	blt $a1, $t5, finished_small_prime_m	# skip the small prime calculations
	li $a0, 0				# set to 0 as default
	jal is_small_prime		# perform is small prime


	#################################################
	# END IS SMALL PRIME, a0 holds small prime or not
	#################################################

finished_small_prime_m:
	
	li $t5, 1
	bne $a0, $t5, continue_mersenne_loop_m	# if not small prime, continue loop 

	# print("Testing p = ", p)
	la $a0, testing			# load line into a0
	li $v0, 4				# printing output
	syscall
	add $a0, $0, $a3	
	li $v0, 1
	syscall	



	# Checking if p % 2 is even or odd
	li $t5, 2
	div $a3, $t5
	mfhi $t5
	beq $t5, $0, not_odd_m	# go to not prime case
	bne $t5, $0, is_odd_m

not_odd_m:
	j continue_mersenne_loop_m

is_odd_m:

	################################
	#	START LLT
	################################



	###############################
	# RESETTING B's With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 1					# Set length of array A
	sw $t0, ($t8)				# stores first element as 4


	###############################
	# RESETTING A's With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 2					# Set length of array A
	sw $t0, ($t8)				# stores first element as 4


	###############################
	# RESETTING TEMP With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's



	#######################################
	#	Performing temp = a;
	#######################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# modifying index 0
	jal, start_heap_t7			# Start array at 0
	add $t4, $t8, $0			# t4 = t8

	lw $a1, len_a				# get length of A

	# INITALIZE LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	# INITALIZE LENGTH OF TEMP
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of array A


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	jal store_a_in_temp			# store A into temp

	li $s6, 1					# s6 will be counter for power loop




pow_big_for_loop_llt_m: 


	############# BEGIN MULTIPLICAITION ##################
	#		c = mult_big(temp, a);
	############ START MULTIPLICATION #####################


	#### RESETTING C ######
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c



	########################################################
	# GET LENGTH OF temp
	########################################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value




	########################################################
	# GET LENGTH OF A
	########################################################
	
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a2, $0, $t6			# a2 = t6 value

	jal reset_counter_t9		# reset counter at t9




	#	a1 = temp.n
	#	a2 = a.n
	#	t5 = carry
	#	s1 = j


	li $t4, 4			# temp constant

mult_beg_loop_m:					# for(int i = 0; i < b.n; i++)
	li $t5, 0					# carry is 0
	add $s1, $t9, $0			# j = i, s1 = j
	add $t0, $a1, $t9			# t0 = a.n + i


	mul $t2, $t9, $t4		# 4*i for offset
	#mflo $t2			# t2 = 4*i


inner_loop_m: 			# for(j = i, j< a.n + i; j++)

	mul $t1, $s1, $t4		# 4*j for offset
	#mflo $t1			# t1 = 4*j


	sub $t3, $t1, $t2	# t3 = t1 - t2, t3 = j-i

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	# Get b[i], $s3
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length B index	
	add $t7, $t7, $t2			# go to index in B
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s3, $0, $t6			# s3 = b[i]

	# Get a[j-i], $s4
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp				# Start at the length A index	
	add $t7, $t7, $t3			# go to index in 
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s4, $0, $t6			# 

	mul $s5, $s3, $s4				# b[i] * a[j-i]

	add $s5, $s5, $t5			# add carry
	add $s5, $s5, $s2			# add c[j]


	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4			# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	sw $s4, ($t8)


	addi $s1, $s1, 1			# j += 1
	bne $s1, $t0, inner_loop_m	# Break otu of loop when j = a.n + i




	ble $t5, $0, continue_outer_for_m	# if carry <= 0, skip the next statements
	# if not, do the following statements:



	mul $t1, $s1, $t4		# 4*j for offset

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	add $s5, $s2, $t5			# val = c[j] + carry
	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4					# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	add $t6, $s4, $0			# t6 = s4
	jal set_val					# store value from t6 into c[j]




continue_outer_for_m:
	addi $t9, $t9, 1			# increase counter
	bne $t9, $a2, mult_beg_loop_m	# redo loop if counter i != length

	############# END MULTIPLICAITION ##################





	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	# STORE UPDATED LENGHT OF C INTO TEMP LEN
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)


	#####################################
	# NEED TO STORE VALUES OF C INTO TEMP
	#####################################
	# a1 = lenght of temp
	# t4 = address of c
	# t8 = address of temp

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# modifying index 0
	jal, start_heap_t7			# Start array at 0

	add $t4, $t8, $0			# t4 = t8, ! t4 = address for C


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0

	jal store_c_in_temp			# store A into temp



	addi $s6, $s6, 1				# increment counter
	bne $s6, $a3, pow_big_for_loop_llt_m	# reloop




	########## POW_BIG(two,p) COMPLETE #################

	################################
	# subtraction of sub_big(MP, one)
	################################

	#######################
	#### RESETTING C ######
	#######################
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c


	#####################################
	# SUBTRACT (temp - B) = MP - 1
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter
	
	########################################################
	# GET LENGTH OF temp # a1 needs length of top big_int
	########################################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value
	addi $a1, $a1, -1			# subtract len_a - 1
	# a1 = len(a) a2 holds len_b

	jal subtract				# Call subtract

	##########################################
	# BEGIN STORING C into TEMP
	###########################################

	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################

	# STORE UPDATED LENGHT OF C INTO TEMP LEN
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)


	#####################################
	# NEED TO STORE VALUES OF C INTO TEMP
	#####################################
	# a1 = lenght of temp
	# t4 = address of c
	# t8 = address of temp

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# modifying index 0
	jal, start_heap_t7			# Start array at 0

	add $t4, $t8, $0			# t4 = t8, ! t4 = address for C


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# modifying index 0
	jal, start_heap_t7			# Start array at 0

	jal store_c_in_temp			# store A into temp

	##########################################
	# END STORING C into TEMP, finished subtract(MP,1)
	###########################################


	###########################################
	# Change A to big_int(4)
	##########################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 4					# Set length of array A
	sw $t0, ($t8)				# stores first element as 4

	##########################################
	# FOR LOOP FOR LLT
	##########################################

	# a3 still holds prime p
	li $s7, 0
	addi $v1, $a3, -2			# limit of the loop

llt_for_m:
	###########################################
	# Change B to big_int(2), used in FOR loop
	##########################################

	###############################
	# RESETTING B's With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	li $t0, 2					# Set length of array A
	sw $t0, ($t8)				# stores first element as 4



	######################################
	# mult_big(s,s), A = s
	######################################


	#### RESETTING C ######
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c




	########################################################
	# GET LENGTH OF A
	########################################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value
	add $a2, $0, $t6			# a2 = t6 value (B's length)



	jal reset_counter_t9		# reset counter at t9
	li $t4, 4			# temp constant

llt_mult_beg_loop_m:					# for(int i = 0; i < b.n; i++)
	li $t5, 0					# carry is 0
	add $s1, $t9, $0			# j = i, s1 = j
	add $t0, $a1, $t9			# t0 = a.n + i

	mult $t9, $t4		# 4*i for offset
	mflo $t2			# t2 = 4*i

llt_inner_loop_m: 			# for(j = i, j< a.n + i; j++)

	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j

	sub $t3, $t1, $t2	# t3 = t1 - t2, t3 = j-i

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	# Get b[i], $s3
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length B index	
	add $t7, $t7, $t2			# go to index in B
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s3, $0, $t6			# s3 = b[i]

	# Get a[j-i], $s4
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the length A index	
	add $t7, $t7, $t3			# go to index in 
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s4, $0, $t6			# 

	mult $s3, $s4				# b[i] * a[j-i]
	mflo $s5					# s5 is value

	add $s5, $s5, $t5			# add carry
	add $s5, $s5, $s2			# add c[j]


	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4			# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	sw $s4, ($t8)

	addi $s1, $s1, 1			# j += 1
	bne $s1, $t0, llt_inner_loop_m	# Break otu of loop when j = a.n + i

	ble $t5, $0, llt_continue_outer_for_m	# if carry <= 0, skip the next statements
	# if not, do the following statements:

	# NEED TO READD THE INDEX

	mult $s1, $t4		# 4*j for offset
	mflo $t1			# t1 = 4*j

	# Get c[j], $s2
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length C index	
	add $t7, $t7, $t1			# go to position j
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $s2, $0, $t6			# move value from t6 into s2

	add $s5, $s2, $t5			# val = c[j] + carry
	li $s3, 10			# create constant 10
	div $s5, $s3		# val/10		
	mflo $t5			# put val/10 value into carry

	mfhi $s4					# s4 contains val % 10

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	add $t7, $t7, $t1			# go to index in c
	jal, start_heap_t7			# Move address to start of index
	add $t6, $s4, $0			# t6 = s4
	jal set_val					# store value from t6 into c[j]



llt_continue_outer_for_m:
	addi $t9, $t9, 1			# increase counter
	bne $t9, $a2, llt_mult_beg_loop_m	# redo loop if counter i != length



	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################
	
	# Store a1 into len A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)				# store new length into A

	###########################################
	# BEGIN STORE C IN A
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0

	jal reset_counter_t9		# reset counter at t9
	add $t3, $a1, $0			# store length of new C into t3
	jal store_c_in_a			# Store C values into A

	######################
	# END STORE C IN A
	######################



	#######################
	#### RESETTING C ######
	#######################
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c
	########################



	#####################################
	# SUBTRACT
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	

	li $t9, -1					# store -1 as counter
	addi $a1, $a1, -1			# subtract len_a - 1
	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract




	###########################################
	# Compress and store length for C
	###########################################
	lw $a2, len_c				# put length of c into a2
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_c			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0_c		# Obtains number of leading 0's and puts in t6
	

	# Updating length of bigint C
	lw $a1, len_c				# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_c			# Start at the length C index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1


	###########################################
	# End Compress and store length
	# a1 holds the new length
	#
	# Store a1 into len A
	#############################################
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $a1, ($t8)				# store new length into A



	###########################################
	# BEGIN STORE C IN A
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0



	jal reset_counter_t9		# reset counter at t9
	lw	$t3, len_max_arr		# store length of new C into t3

	jal store_c_in_a			# Store C values into A

	######################
	# END STORE C IN A
	######################




	#### AT THIS POINT: s = s*s - 2
	#### Need to do: s mod MP now....



	#######################
	#### RESETTING C ######
	#######################
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_c
	########################




	#####################
	# TEMP = OG_B
	# B needs to be TEMP
	#####################


	###########################################
	# BEGIN STORE TEMP IN B
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_temp				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_b				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6

	# STore length of B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	sw $t6, ($t8)				# store t6 into t8

	jal reset_counter_t9		# reset counter at t9
	jal store_temp_in_b			# Store C values into A

	###########################################
	# END STORE TEMP IN B
	###########################################



	####################################
	# 	PERFORMING MOD BIG
	####################################



compare_big_a_b_1_m:				# while (compare_big(a,b) == 1)

	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1



	li $t5, -1								# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_m	# go to first_mod_left_shift
	li $t5, 0								# store temporary -1
	beq $a0, $t5, first_mod_left_shift_b_m	# go to first_mod_left_shift

	##################################
	# else, perform a right shift on B
	##################################


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap

	li $t6, 1					# t6 holds shift value
	jal obtain_shift_offset		# t6 holds shift offset

	lw $t7, index_b				# Start at the length B index
	jal obtain_length_shift_t7	# obtain 4 * length into t7
	addi $a1, $a1, 1			# add 1 to a1, for counter purposes
	jal start_heap_t7			# start heap index at t7 (end of significant big int)
	jal shift_right				# start the shift		

	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	# End Compress and store length



	j compare_big_a_b_1_m				# jump back to compare_big_1





# END while (compare_big(a,b) == 1)

first_mod_left_shift_b_m: 

	


	###########################################
	# Compress and store length
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################




	###################################################
	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index
	jal shift_left				# Shifts left

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7

	jal fill_shift_left_0		# Fill rest with 0's


	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	####################
	# END SHIFT LEFT
	####################



compare_big_b_ogb_n1_m:			#  compare_big(b, og_b) != -1



	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length B and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp		# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length temp and puts in t1

	li $a3, -1					# Assume t0 - t1 is negative
	jal check_lengths_b_temp		# checks length, skips next instruction if =
	jal check_comprehensive_b_temp	# when t0 - t1 = 0

	# END of compare big 1
	# a3 holds -1, 0, 1


	li $t5, -1
	beq $a3, $t5, continue_loop_llt_m # if compare(b, orig_b) == -1 only return A
	


	# else continue

compare_big_a_b_n1_m:				# compare_big(a,b) != -1



	jal reset_counter_t9		# reset counter at t9
	lw $t6, len_max_arr			# Stores max length array value into t6, used for counter
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $t0, ($t8)				# Gets length A and puts in t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# modifying index t7
	jal, start_heap_t7			# Start array at t7
	lw $t1, ($t8)				# Gets length B and puts in t1

	li $a0, -1					# Assume t0 - t1 is negative
	jal check_lengths			# checks length, skips next instruction if =
	jal check_comprehensive		# when t0 - t1 = 0

	# END of compare big 1
	# a0 holds -1, 0, 1



	li $t5, -1		
	beq $a0, $t5, second_mod_shift_left_m	# if a0 = -1, go to second shift left

	# else, subtract and continue






	#####################################
	# SUBTRACT
	#####################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# Start at the beginning of A	
	jal, start_heap_t7			# Move address to start of index
	la $t0, ($t8)				# put address of where A is into t0

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t1, ($t8)				# put address of where B is into t1


	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# Start at the beginning of B	
	jal, start_heap_t7			# Move address to start of index
	la $t2, ($t8)				# put address of where B is into t2

	li $t9, -1					# store -1 as counter

	# GET UPDATED LENGTH OF A
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	add $a1, $t6, $0
	addi $a1, $a1, -1			# subtract len_a - 1



	# GET UPDATED LENGTH OF B
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b 		# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	add $a2, $t6, $0


	# SOMETHING WRONG WITH SUBTRACTION, GETTING WRONG LENGTHS PROBABLY
	# a1 = len(a) a2 holds len_b
	jal subtract				# Call subtract



	###############################
	# RESETTING A's With 0's
	###############################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	jal fill_zero_norm			# Fill A with 0's



	###############################
	# Filling A values with C result
	###############################

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_a				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t0, $0, $t8			# store address A at t0

	jal reset_heap_index		# resets t8 back to start of heap	
	lw $t7, index_c				# Start at the beginning of A
	jal, start_heap_t7			# Move address to start of index
	add $t1, $0, $t8			# store address C at t0


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# gets the length
	add $t3, $0, $t6			# store t6 into t3
	jal store_c_in_a			# Store C values into A



	###########################################
	# UPDATE LENGTH OF A
	# Compress and store length
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_a			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6



	# Updating length of bigint A
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1

	#Check number of 0's

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_a			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	j continue_a_b_n1_m


	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################


continue_a_b_n1_m:

	j compare_big_a_b_n1_m		# end Inner while loop
	


second_mod_shift_left_m:
	###########################################
	# Compress and store length B
	###########################################
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length B index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length B index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	###########################################
	# End Compress and store length
	# a1 holds the new length
	###########################################





	###################################################
	# BEGIN SHIFT LEFT
	##################################################

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0

	li $t6, 1					# t6 holds shift value
	sub $a1, $a1, $t6			# Gets number of value to shift
	jal obtain_shift_offset		# Converts shift index to 4*shift index

	beq $a1, $0, zero_case_m		# skip rest if zero case

	jal shift_left				# Shifts left
	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 1					# t6 holds shift value
	lw $t7, index_b				# start at beginning of B in heap
	jal set_t7_end_bigint		# set to end of singificant big int
	jal start_heap_t7			# Start array at t7
	jal fill_shift_left_0		# Fill rest with 0's
	j compress_2_m

zero_case_m:
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of B in heap
	jal, start_heap_t7			# Start array at 0
	li $t5, 1
	sw $t5, ($t8)				# store 1 in arr


compress_2_m:
	# Compress and store length
	jal reset_heap_index		# resets t8 back to start of heap
	li $t6, 0					# t6 will hold number of 0's in front
	lw $t7, index_len_b			# Start at the length A index	
	jal set_t7_end				# t7 has end of array index
	jal, start_heap_t7			# start heap index at t7
	jal, obtain_lead_0			# Obtains number of leading 0's and puts in t6

	# Updating length of bigint B
	lw $a1, len_max_arr			# put value of len array into a1
	sub $a1, $a1, $t6			# Subtracts number of leading 0's, store in a1
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_b			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_len					# Set length of of value in a1

	####################
	# END SHIFT LEFT
	####################



	j compare_big_b_ogb_n1_m		# end outter while loop

	################ END BIG MOD ###################




continue_loop_llt_m:


	addi $s7, $s7, 1			# increment s7 counter
	bne $s7, $v1, llt_for_m		# keep looping until max p hit

	############################
	# END OF OUTER FOR LOOP
	# At this point, s = (s*s)-2 mod mp
	# Where A represents s
	############################




	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# start at beginning of A in heap
	jal, start_heap_t7			# start heap index at t7
	jal check_all_zeros			# checks array for all 0

	 # t9 holds number of zeros
	 lw $t3, len_max_arr		# t3 holds len of max arr

	 li $a1, 1					
	 beq $t9, $t3, continue_isprime_check_m	# if t9 = t3, num of 0's  = len of arr, skip

	 li $a1, 0	# else = 0


	
continue_isprime_check_m:
	
	beq $a1, $0, no_located_prime_m		# go to no_located_prime
	bne $a1, $0, located_prime_m			# located prime

no_located_prime_m:
	la $a0, not_prime			# load line into a0
	li $v0, 4					# printing output
	syscall
	j continue_mersenne_loop_m

located_prime_m:
	
	# TEMP holds 2^p - 1!!!

	la $a0, found_prime			# load line into a0
	li $v0, 4					# printing output
	syscall

	########################################################
	# GET LENGTH OF temp
	########################################################

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_len_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal get_val					# store value in t6
	add $a1, $0, $t6			# a1 = t6 value

	############################################
	# PRINT THE bigint temp
	###########################################
	# a1 holds number of significant digits/length
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp			# Start at the length A index	
	jal, start_heap_t7			# Move address to start of index
	jal set_t8_non_0_end		# sets t8 to furthest non-zero index
	add $t9, $0, $a1			# t9 holds updated length of A

	jal print_big				# Print bigint temp

	la $a0, newline				# print new line
	li $v0, 4					# printing output
	syscall

	j continue_mersenne_loop_m

continue_mersenne_loop_m:
	##########################################
	# restoring a3 as counter
	##########################################
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_prim			# modifying index 0
	jal, start_heap_t7			# Start array at 0
	lw $a3, ($t8)

	 # a1 = 1: is_prime is true
	 # a1 = 0: is_prime is false

	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_limit			# get limit index
	jal, start_heap_t7			# Start array at 0
	lw $t5, ($t8)

	addi $a3, $a3, 1					# increment to next prim

	bne $a3, $t5, begin_mersenne_for_m	# loop if not equal to limit
	j end_program





	j end_program # !end




print_output:
	############################################
	# PRINT THE HEAP Everything
	###########################################

	la $a0, outputline			# load line into a0
	li $v0, 4					# printing output
	syscall

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_a				# start at beginning of A in heap
	jal, start_heap_t7			# start heap index at t7
	jal print_heap_bigint		# print value of big int

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_b				# start at beginning of A in heap
	jal, start_heap_t7			# start heap index at t7
	jal print_heap_bigint		# print value of big int

	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_c				# start at beginning of A in heap
	jal, start_heap_t7			# start heap index at t7
	lw $t0, len_c
	jal print_heap_bigint_c		# print value of big int


	jal reset_counter_t9		# reset counter at t9
	jal reset_heap_index		# resets t8 back to start of heap
	lw $t7, index_temp				# start at beginning of A in heap
	jal, start_heap_t7			# start heap index at t7
	jal print_heap_bigint		# print value of big int

	j end_program


########################################
#
#
#			HELPER FUNCTIONS
#
#
########################################

reset_all_registers:

	# Clear all v registers
	li $v0, 0	
	li $v1, 0

	# Clear all a registers
	li $a0, 0
	li $a1, 0
	li $a2, 0
	li $a3, 0

	# Clear all t registers
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	li $t4, 0
	li $t5, 0
	li $t6, 0
	li $t7, 0
	li $t8, 0
	li $t9, 0

	# Clear all s registers
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0

	jr $ra


check_all_zeros:
	lw $t3, len_max_arr
	lw $t4, ($t8)		# t4 is word at t8
	bne $t4, $0, return	# return if a nonzero is detectd
	addi, $t9, $t9, 1	# increment by 1
	bne $t9, $t3, check_all_zeros	# loop again if non-zero found

	jr $ra


store_temp_in_b:
	# t0, address temp
	# t1, address B
	# t9 counter
	# t6, length of temp

	lw $s1, ($t0)	# put value of temp into s1
	sw $s1, ($t1)	# put value of temp into address B
	addi $t0, $t0, 4	# move to next spot in A
	addi $t1, $t1, 4	# move to next spot in C
	addi $t9, $t9, 1	# move to next spot in C
	bne $t9, $t6, store_temp_in_b	# keep going until len A is reached

	jr $ra

store_a_in_temp:
	# t8 will hold address of temp
	# t4 will hold address of A
	# a1 = len(A)

	lw $t0, ($t4)
	sw $t0, ($t8)
	addi $t4, $t4, 4
	addi $t8, $t8, 4
	addi $t9, $t9, 1
	bne $t9, $a1, store_a_in_temp

	jr $ra

store_c_in_temp:
	# t8 will hold address of temp
	# t4 will hold address of C
	# a1 = len(temp)

	lw $t0, ($t4)
	sw $t0, ($t8)
	addi $t4, $t4, 4
	addi $t8, $t8, 4
	addi $t9, $t9, 1
	bne $t9, $a1, store_c_in_temp

	jr $ra

store_c_in_a:
	# t0, address A
	# t1, address C
	# t9 counter
	# t3, length of A

	lw $s1, ($t1)	# put value of C into s1
	sw $s1, ($t0)	# put value of C into address A
	addi $t0, $t0, 4	# move to next spot in A
	addi $t1, $t1, 4	# move to next spot in C
	addi $t9, $t9, 1	# move to next spot in C
	bne $t9, $t3, store_c_in_a	# keep going until len A is reached

	jr $ra

is_small_prime:
		
	div $a2, $t9		# divide a2/t9
	mfhi $t0			# t0 has a2 mod t9
	beq $t0, $0, return	# return only if = 0
	addi $t9, $t9, 1	# increment t9 by 1
	bne $t9, $a1, is_small_prime	# for loop continue
	li $a0, 1			# otherwise, a0 = 1

	jr $ra


subtract:
	add $v0, $0, $ra		# save ra into v0
	addi $sp, $sp, -12		# make room for 3 words on stack, will hold addresses
	sw $t0, 0($sp)			# Put address A into bottom of stack
	sw $t1, 4($sp)			# Put address B into middle of stack
	sw $t2, 8($sp)			# Put address C into top of stack

	lw $s1, ($t0)			# put word at addr A into s1
	lw $s2, ($t1)			# put word at addr B into s2
	lw $s4, 4($t0)			# get the next digit as well

	jal subtract_helper		# use subtract helper 

	addi $sp, $sp, 12		# remove room on stack
	jr $v0					# return from original

subtract_helper:
	bge $s1, $s2, digit_a_greater	# if digit a is greater
	blt	$s1, $s2, digit_b_greater	# if digit b is greater

	
digit_a_greater:
	sub $s3, $s1, $s2		# s3 = s1 - s2
	sw $s3, ($t2)			# Store value into array c

	addi $t9, $t9, 1		# increment counter
	addi $t0, $t0, 4		# move to next digit
	addi $t1, $t1, 4		# move to next digit
	addi $t2, $t2, 4		# move to next digit

	add $s1, $s4, $0		# put word at previously stored s4 into s1

	lw $s4, 4($t0)			# get the next digit as well
	lw $s2, ($t1)			# put word at addr B into s2
	bne $t9, $a1, subtract_helper	# keep performing if there are digits left
	jr $ra

digit_b_greater:
	# a1 = len(a) a2 holds len_b


	#lw $s1, ($t0)			# load digit of a
	addi $s1, $s1, 10		# add 10 to s1
	sub $s3, $s1, $s2		# s3 = s1 - s2
	sw $s3, ($t2)			# Store value into array c

	addi $s4, $s4, -1		# take one value away from next value
	add $s1, $s4, $0		# put word at previously stored s4 into s1

	addi $t9, $t9, 1		# increment counter
	addi $t0, $t0, 4		# move to next digit
	addi $t1, $t1, 4		# move to next digit
	addi $t2, $t2, 4		# move to next digit

	lw $s2, ($t1)			# put word at addr B into s2
	lw $s4, 4($t0)			# get the next digit as well

	bne $t9, $a1, subtract_helper	# keep performing if there are digits left
	
	jr $ra

check_comprehensive_b_temp:
	li $a3, 0				# store a3 as 0
	add $s1, $0, $ra		# save ra into s0

	addi $sp, $sp, -8		# make room for 2 words on stack

	add $t8, $0, $gp		# reset t8 address
	lw $t7, index_len_b		# set starting index to where length is stored
	addi $t7, $t7, -4		# decrement by 1 word, to get end of bigint arr
	add $t8, $t8, $t7		# added t7 to t8 (end addr of first arr)
	sw $t8, 0($sp)			# Put addr1 on bottom

	add $t8, $0, $gp		# reset t8 address
	lw $t7, index_len_temp	# set starting index to where length is stored
	addi $t7, $t7, -4		# decrement by 1 word, to get end of bigint arr
	add $t8, $t8, $t7		# added t7 to t8 (end addr of second arr)
	sw $t8, 4($sp)			# Put addr1 on top

	lw $t0, 0($sp)			# put address1 into t0	
	lw $t1, 4($sp)			# put address2 into t1

	jr iterate_check_temp	
	addi $sp, $sp, 8		# remove room on stack

	jr $s1					# jump back to original function location

check_comprehensive:
	li $a0, 0				# store a0 as 0
	add $s0, $0, $ra		# save ra into s0

	addi $sp, $sp, -8		# make room for 2 words on stack

	add $t8, $0, $gp		# reset t8 address
	lw $t7, index_len_a		# set starting index to where length is stored
	addi $t7, $t7, -4		# decrement by 1 word, to get end of bigint arr
	add $t8, $t8, $t7		# added t7 to t8 (end addr of first arr)
	sw $t8, 0($sp)			# Put addr1 on bottom

	add $t8, $0, $gp		# reset t8 address
	lw $t7, index_len_b		# set starting index to where length is stored
	addi $t7, $t7, -4		# decrement by 1 word, to get end of bigint arr
	add $t8, $t8, $t7		# added t7 to t8 (end addr of second arr)
	sw $t8, 4($sp)			# Put addr1 on top

	lw $t0, 0($sp)			# put address1 into t0	
	lw $t1, 4($sp)			# put address2 into t1

	jr iterate_check	
	addi $sp, $sp, 8		# remove room on stack

	jr $s0					# jump back to original function location

iterate_check_temp:
	lw $t2, ($t0)				# word for end of addr1
	lw $t3, ($t1) 				# word for end of addr2
	bgt $t2, $t3, arr_1_bigger_temp	# jump to arr_1_bigger
	bgt $t3, $t2, arr_2_bigger_temp	# jump to arr_2_bigger
	addi $t0, $t0, -4			# decrement arr1
	addi $t1, $t1, -4			# decrement arr2
	addi $t9, $t9, 1			# add 1 to counter
	bne $t9, $t6, iterate_check_temp	# keep performing if there are digits left
	jr $ra

iterate_check:
	lw $t2, ($t0)				# word for end of addr1
	lw $t3, ($t1) 				# word for end of addr2
	bgt $t2, $t3, arr_1_bigger	# jump to arr_1_bigger
	bgt $t3, $t2, arr_2_bigger	# jump to arr_2_bigger
	addi $t0, $t0, -4			# decrement arr1
	addi $t1, $t1, -4			# decrement arr2
	addi $t9, $t9, 1			# add 1 to counter
	bne $t9, $t6, iterate_check	# keep performing if there are digits left
	jr $ra

arr_1_bigger:
	li $a0, 1
	jr $ra

arr_2_bigger:
	li $a0, -1
	jr $ra

arr_1_bigger_temp:
	li $a3, 1
	jr $ra

arr_2_bigger_temp:
	li $a3, -1
	jr $ra


check_lengths_b_temp:
	sub $t3, $t0, $t1	# t3 = value of t0-t1
	beq $t3, $0, return	# return if they're equal, need to do comprehensive check
	addi $ra, $ra, 4	# Skip check_comprehnsive
	blt $t3, $0, return	# return if t3 < 0, can just print -1
	li $a3, 1
	jr $ra

check_lengths:
	sub $t3, $t0, $t1	# t3 = value of t0-t1
	beq $t3, $0, return	# return if they're equal, need to do comprehensive check
	addi $ra, $ra, 4	# Skip check_comprehnsive
	blt $t3, $0, return	# return if t3 < 0, can just print -1
	li $a0, 1
	jr $ra
	
shift_left:
	add $t0, $t8, $t6	# get index + shift address
	lw $t1, ($t0)		# load word into t1
	sw $t1, ($t8)		# Store t1 into designated area
	addi $t8, $t8, 4	# increment to next t8
	addi $t9, $t9, 1	# increment counter by 1
	bne $t9, $a1, shift_left	# if counter hasn't reached length, keep going
	jr $ra

fill_shift_left_0:			# Fills the un-shifted with 0's
	sw $0, ($t8)			# put 0 in t8 index
	addi $t8, $t8, 4		# increment to next t8
	addi $t9, $t9, 1					# increment counter by 1
	bne $t9, $t6, fill_shift_left_0		# if counter hasn't reached length, keep going
	jr $ra

shift_right:		
	# $t6 = shift * 4, a1 = len, t7 = len*4 + shift*4, t8 current position
	sub $t0, $t8, $t6	# t0 holds value of t8 - shift
	lw $t1, ($t0)		# gets the word associated with t8-shift
	sw $t1, ($t8)		# store the word at t8
	sw $0, ($t0)		# replace shifted word with 0
	addi $t9, $t9, 1	# increment counter by 1
	addi $t8, $t8, -4	# move t8 back
	bne $t9, $a1, shift_right	# if counter hasn't reached length, keep going
	jr $ra

obtain_length_shift_t7:			# input: t6, shift offset, t7, start of index bigint
	li $t5, 4					# define constant 4
	mul $t5, $a1, $t5  				# multiply length of array by 4
	add $t7, $t7, $t5			# add offset to $t7
	add $t7, $t7, $t6			# returns 4 * (length + shift)
	jr $ra

obtain_shift_offset:			# obtains 4 * shift length
	li $t5, 4					# load constant 4
	mul $t6, $t6, $t5				# multiply shift value by 4
	jr $ra

set_len:
	sw $a1, ($t8)				# Stores length of a into heap
	jr $ra

set_val:
	sw $t6, ($t8)				# Stores value at t6 into heap
	jr $ra

get_val:
	lw $t6, ($t8)				# Loads value at address into t6 register
	jr $ra				

set_t8_non_0_end_c:
	lw $t0 len_c				# Loads max length array into t0
	beq $a1, $t0, return		# checks if a1 is max length, if so, return (no leading 0's)
	li $t0, 4					# store 4 temporarily in t0
	mul $t1, $a1, $t0				# multiply length of array by 4
	sub $t1, $t1, $t0			# Subtract 4 and store into t1 (adjust for indices)
	add $t8, $t8, $t1			# t8 holds new address based on significant length
	jr $ra

set_t8_non_0_end:
	lw $t0 len_max_arr			# Loads max length array into t0
	beq $a1, $t0, return		# checks if a1 is max length, if so, return (no leading 0's)
	li $t0, 4					# store 4 temporarily in t0
	mul $t1, $a1, $t0				# multiply length of array by 4
	sub $t1, $t1, $t0			# Subtract 4 and store into t1 (adjust for indices)
	add $t8, $t8, $t1			# t8 holds new address based on significant length
	jr $ra

set_t7_end_bigint:
	# a1 has len, t7 is index
	li $t5, 4					# define constant 4
	mul $t5, $a1, $t5  				# multiply length of array by 4
	add $t7, $t7, $t5	
	jr $ra

set_t7_end:						# Needs t7 = index_len_(x): where length is stored
	add $t7, $t7, -4			# decrement to end of array
	jr $ra							
	
start_heap_t7:					# Moves the heap addr (t8) to the index t7
	add $t8, $t8, $t7			# Go to index t7 for t8
	jr $ra

obtain_lead_0_c:					# Compresses value, stores number of 0's at t6
	lw $t5, len_c					# get length of max arr
	lw $t0, ($t8)					# Load heap at address t8
	bne $t0, $0, return				# the value is not 0, return
	addi $t6, $t6, 1				# incrememnt t6, counter for 0's
	addi $t8, $t8, -4				# go down the array
	bne $t6, $t5, obtain_lead_0_c	# keep decrementing until length of max array

obtain_lead_0:					# Compresses value, stores number of 0's at t6
	lw $t5, len_max_arr		# get length of max arr
	lw $t0, ($t8)				# Load heap at address t8
	bne $t0, $0, return			# the value is not 0, return
	addi $t6, $t6, 1			# incrememnt t6, counter for 0's
	addi $t8, $t8, -4			# go down the array
	bne $t6, $t5, obtain_lead_0	# keep decrementing until length of max array

return:
	jr $ra

malloc_heap:
	lw $a0 heap_size
	li $v0 9 				# syscall 9 (sbrk)
	syscall
	la $gp, ($v0)			# gp = base address of heap
	la $t8, ($gp)			# t8 = temporary address changer
	jr $ra

init_heap:
	sw $0, ($t8)			# loads the word at a0
	addi $t9, $t9, 4		# Increment counter by 1
	addi $t8, $t8, 4		# go to next space in heap
	bne $t9, $t0, init_heap	# If counter != len(arr), redo
	jr $ra

fill_zero_norm:
	lw $t5, len_max_arr		# get length of max arr
	sw $0, ($t8)			# loads the word at a0
	addi $t9, $t9, 1		# Increment counter by 1
	addi $t8, $t8, 4		# go to next space in heap
	bne $t9, $t5, fill_zero_norm	# If counter != len(arr), redo
	jr $ra

fill_zero_c:
	lw $t5, len_c		# get length of max arr
	sw $0, ($t8)			# loads the word at a0
	addi $t9, $t9, 1		# Increment counter by 1
	addi $t8, $t8, 4		# go to next space in heap
	bne $t9, $t5, fill_zero_c	# If counter != len(arr), redo
	jr $ra


reset_heap_index:			# resets register t8
	la $t8, ($gp)			# t8 = temporary address changer
	jr $ra

reset_counter_t9:			# t9 is counter
	li $t9, 0				# set register t9 to 0
	jr $ra					# jump back


init_arr_val:				# initializes arr's val:
	lw $t0, ($a0)			# loads the word at a0
	sw $t0, ($t8)			# stores word at heap index
	addi $t9, $t9, 1		# Increment counter by 1
	addi $a0, $a0, 4		# go to next word in a0
	addi $t8, $t8, 4		# go to next space in heap
	bne $t9, $a1, init_arr_val	# If counter != len(arr), redo

	jr $ra


print_heap_bigint_c:			# Prints bigint stored in heap, default format
	lw $a0, ($t8)
	li $v0, 1
	syscall
	addi $t9, $t9, 1
	addi $t8, $t8, 4
	bne $t9, $t0, print_heap_bigint_c
	la $a0, newline			# Loads space
	li $v0, 4				# print string
	syscall
	jr $ra

print_heap_bigint:			# Prints bigint stored in heap, default format
	lw $a0, ($t8)
	li $v0, 1
	syscall
	addi $t9, $t9, 1
	addi $t8, $t8, 4
	lw $t0, len_max_arr
	bne $t9, $t0, print_heap_bigint
	la $a0, newline			# Loads space
	li $v0, 4				# print string
	syscall
	jr $ra

print_heap_val:				# Prints value in heap at index t7
	lw $a0, ($t8)
	li $v0, 1
	syscall
	la $a0, newline			# Loads space
	li $v0, 4				# print string
	syscall
	jr $ra

print_big:					# Prints the real big integer value in heap 
	lw $a0, ($t8)
	li $v0, 1
	syscall
	addi $t9, $t9, -1
	addi $t8, $t8, -4
	li $t0, 10
	bne $t9, $0, print_big
	jr $ra


end_program:
	li $v0, 10            	# 10 is the exit syscall.
	syscall               	# exit


