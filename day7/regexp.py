import re

# Problem 1

# a
print "Problem 1"
print "part a"
pattern = re.compile("^01(11)*0$")
print bool(pattern.match("01110")) == True
print bool(pattern.match("000")) == False
print bool(pattern.match("0110")) == False

# Problem 2

# b

print "part b"

pattern = re.compile("^0*10*$")

print bool(pattern.match("01110")) == False
print bool(pattern.match("000")) == False
print bool(pattern.match("010")) == True
print bool(pattern.match("001000")) == True

print "part c"

pattern = re.compile("^1*$")

print bool(pattern.match("01110")) == False
print bool(pattern.match("000")) == False
print bool(pattern.match("010")) == False
print bool(pattern.match("111")) == True

print "Problem 2"
print "part a"

pattern = re.compile("^(ab)*$")

print bool(pattern.match("ab")) == True
print bool(pattern.match("ababab")) == True
print bool(pattern.match("aabab")) == False

print "part b"

pattern = re.compile("^(a(ab)*b)*$")

print bool(pattern.match("abaababbab")) == True
print bool(pattern.match("aaabbabb")) == False

print "part c"

pattern = re.compile("^(a(a(ab)*b)*b)*$")

print bool(pattern.match("aabaababbbab")) == True
print bool(pattern.match("aaaabbbb")) == False