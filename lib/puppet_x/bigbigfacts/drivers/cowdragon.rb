require_relative '../bbpfdrivers.rb'
# Drivers to Load the COWDRAGON method
class BBPFDrivers::COWDRAGON
  def initialise; end

  def compressmethods
    scriptname = " bash  #{File.join(File.dirname(__FILE__), '/cowdragon.sh')}"

    {
      'cowdragon::shellout2' => proc { |data, _info: {}|
                                  "\n" + Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data,
                                                            "( echo a | #{scriptname} > /dev/null || sudo yum install -y cowsay ) && ( cat <TMPDIR>/data.dat |  #{scriptname}  )", _info: _info)
                                },

      'cowdragon::shellout2::pipein::pipeout' => proc { |data, _info: {}|
                                                   "\n" + Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, scriptname.to_s, _info: _info)
                                                 },
      'cowdragon::shellout2::filein::pipeout' => proc { |data, _info: {}|
                                                   "\n" + Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, "cat <TMPDIR>/data.dat | #{scriptname}", _info: _info)
                                                 },
      'cowdragon::shellout2::filein::fileout' => proc { |data, _info: {}|
                                                   "\n" + Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, "cat <TMPDIR>/data.dat | #{scriptname} > <TMPDIR2>/data.dat",
                                              '<TMPDIR2>/data.dat', _info: _info)
                                                 },

      'cowdragon' => proc { |data, _info: {}|
                       "\n" + Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, "cat <TMPDIR>/data.dat |  #{scriptname}  ", _info: _info)
                     }
    }
  end

  def decompressmethods
    {
      'cowdragon::shellout2' => proc { |data, _info: {}| data },
      'cowdragon::shellout2::pipein::pipeout' => proc { |data, _info: {}| data },
      'cowdragon::shellout2::filein::pipeout' => proc { |data, _info: {}| data },
      'cowdragon::shellout2::filein::fileout' => proc { |data, _info: {}| data },
      'cowdragon' => proc { |data, _info: {}|         data }
    }
  end

  # rubocop:enable Style/ClassAndModuleChildren
  def test_methods
    t = {
      'cowdragon' => proc { |data, _info: {}| # rubocop:disable Lint/UnderscorePrefixedVariableName
        methodname = if _info.key?('m')
                       _info['m']
                     else
                       'cowdragon'
                     end
        cowsaydata = data.split("\n")[0].gsub(%r{[^a-zA-Z 0-9]\n}, '')[0..5]
        data if compressmethods[methodname].call(cowsaydata, _info: _info).include?(cowsaydata)
        # Adjusted it... For CowSay, there is not such thing as inverse function. So This test is change to check CowSay AsciiART is generated properly.
      }
    }
    compressmethods.keys.select { |mname| mname.include?('cowdragon::') }.each do |methodname|
      t[methodname] = proc { |data, _info: {}| test_methods['cowdragon'].call(data, _info: _info) } # rubocop:disable Lint/UnderscorePrefixedVariableName
    end
    t
  end

  alias encodemethods compressmethods
  alias decodemethods decompressmethods

  def autoload_declare; end
end
