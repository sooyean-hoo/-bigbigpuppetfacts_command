require_relative '../bbpfdrivers.rb'
# Drivers to Load the COWSAY method
class BBPFDrivers::COWSAY
  def initialise; end

  def compressmethods
    {
      'cowsay::shellout2' => proc { |data, _info: {}|
                               "\n" + Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data,
                                                      '( echo a | cowsay > /dev/null || sudo yum install -y cowsay ) && ( cat <TMPDIR>/data.dat |  cowsay  )', _info: _info)
                             },

      'cowsay::shellout2::pipein::pipeout' => proc { |data, _info: {}|
                                                "\n" + Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, 'cowsay', _info: _info)
                                              },
      'cowsay::shellout2::filein::pipeout' => proc { |data, _info: {}|
                                                "\n" + Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, 'cat <TMPDIR>/data.dat | cowsay', _info: _info)
                                              },
      'cowsay::shellout2::filein::fileout' => proc { |data, _info: {}|
                                                "\n" + Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, 'cat <TMPDIR>/data.dat | cowsay > <TMPDIR2>/data.dat',
'<TMPDIR2>/data.dat', _info: _info)
                                              },

      'cowsay' => proc { |data, _info: {}|
                    "\n" + Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, 'cat <TMPDIR>/data.dat |  cowsay  ', _info: _info)
                  }
    }
  end

  def decompressmethods
    {
      'cowsay::shellout2' => proc { |data, _info: {}| data },
      'cowsay::shellout2::pipein::pipeout' => proc { |data, _info: {}| data },
      'cowsay::shellout2::filein::pipeout' => proc { |data, _info: {}| data },
      'cowsay::shellout2::filein::fileout' => proc { |data, _info: {}| data },
      'cowsay' => proc { |data, _info: {}|         data }
    }
  end

  # rubocop:enable Style/ClassAndModuleChildren
  def test_methods
    t = {
      'cowsay' => proc { |data, _info: {}| # rubocop:disable Lint/UnderscorePrefixedVariableName
        methodname = if _info.key?('m')
                       _info['m']
                     else
                       'cowsay'
                     end
        cowsaydata = data.split("\n")[0].strip.gsub(%r{[^a-zA-Z 0-9]\n}, '')[0..5]

        o = compressmethods[methodname].call(cowsaydata, _info: _info)

        data if compressmethods[methodname].call(cowsaydata, _info: _info).include?(cowsaydata)
        # Adjusted it... For CowSay, there is not such thing as inverse function. So This test is change to check CowSay AsciiART is generated properly.
      }
    }
    compressmethods.keys.select { |mname| mname.include?('cowsay::') }.each do |methodname|
      t[methodname] = proc { |data, _info: {}| test_methods['cowsay'].call(data, _info: _info) } # rubocop:disable Lint/UnderscorePrefixedVariableName
    end
    t
  end

  alias encodemethods compressmethods
  alias decodemethods decompressmethods

  def autoload_declare; end
end
