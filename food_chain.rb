# required class for test file
class FoodChain

	# function called from test file
	def self.song
		animals = ['fly', 'spider', 'bird', 'cat', 'dog', 'goat', 'cow', 'horse'] # array of animals in order of story appearance
		
		animalRhymes = [ "", 
						"wriggled and jiggled and tickled inside her.\n", 
						"How absurd to swallow a bird!\n", 
						"Imagine that, to swallow a cat!\n", 
						"What a hog, to swallow a dog!\n", 
						"Just opened her throat and swallowed a goat!\n", 
						"I don't know how she swallowed a cow!\n", 
						"She's dead, of course!\n"] # rymes that belong to the animal in the animals array where the index values are equal

		firstLineTemplate = "I know an old lady who swallowed a {{animal}}.\n" #template variable for the first line of each paragraph
		chainStr = "I don't know why she swallowed the fly. Perhaps she'll die.\n\n" # dynamically generated chain section of paragraphs the prepends new test each iteration in the looop
		chainTemplate = "She swallowed the {{animal}} to catch the {{prev_animal}}{{extra}}.\n" # template that prepends to chainStr on each iteration
		song = "" # main variable that will contain the finished song

		# loop over animals array and generate a paragraph for each iteration
		animals.each_with_index {|animal, i| 
			
			# first interation of array
			if i == 0 
				# make first line
				song += makeFirstLine(firstLineTemplate, animal)
				# make chain
				song += chainStr

			elsif i == animals.length - 1
				# make first line
				song += makeFirstLine(firstLineTemplate, animal)
				# make rhyme
				song += animalRhymes[i]

			else
				# make first line
				song += makeFirstLine(firstLineTemplate, animal)
				# make rhyme
				song += if i == 1 then "It " + animalRhymes[i] else animalRhymes[i] end
				# make chain
				chainStr = makeChain(chainTemplate, chainStr, animal, animals[i-1], i, animalRhymes[i-1])
				song += chainStr
			end

		}
		return song
	end

	# creates the chained block in each paragraph
	def self.makeChain(chainTemplate, chainStr, animal, prev_animal, i, rhyme)
		newStr = chainTemplate.dup 
		# replaces changable sections of template variables
		newStr = newStr.gsub! '{{animal}}', animal
		newStr = newStr.gsub! '{{prev_animal}}', prev_animal

		# if at index 2 then add extra rhyme to chain
		newStr = if i == 2 then newStr.gsub! '{{extra}}', " that " + rhyme else newStr.gsub! '{{extra}}', "";  end
		# remove trailing new line and full stops from sentence
		newStr = if i == 2 then newStr[0..-3] else newStr;  end

		chainStr = newStr + chainStr
		return chainStr
	end

	# addes the first line to each paragraph
	def self.makeFirstLine(firstLineTemplate, animal)
		temp = firstLineTemplate.dup
		return temp.gsub! '{{animal}}', animal
	end
end