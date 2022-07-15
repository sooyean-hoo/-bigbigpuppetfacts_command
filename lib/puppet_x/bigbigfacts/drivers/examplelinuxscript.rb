require_relative '../bbpfdrivers.rb'
# Drivers to Load the EXAMPLELINUXSCRIPT method
class BBPFDrivers::EXAMPLELINUXSCRIPT
  def initialise; end

  def scriptname_cmd
    " bash  #{File.join(File.dirname(__FILE__), '/examplelinuxscript.sh')}"
  end

  def compressmethods
    {
      'examplelinuxscript' => proc { |data, _info: {}|
                                Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, scriptname_cmd)
                              }
    }
  end

  def decompressmethods
    {
      'examplelinuxscript' => proc { |data, _info: {}|
                                Facter::Util::Bigbigpuppetfacts.decompressmethods['::shellout2'].call(data, scriptname_cmd)
                              }
    }
  end

  # rubocop:enable Style/ClassAndModuleChildren
  def test_methods
    # Use the default on decompressmethods
    {}
  end

  alias encodemethods compressmethods
  alias decodemethods decompressmethods

  def autoload_declare; end
end
