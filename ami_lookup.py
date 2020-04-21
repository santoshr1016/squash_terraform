"""AMI Lookup.

Given an AWS AMI ID and a region where that AMI is found, create a RegionMap
for use with Amazon CloudFormation.

Note it assumes your AWS credentials are set up according to the boto3 guide.
http://boto3.readthedocs.io/en/latest/guide/configuration.html.

TODO more error handling etc

Usage:
  ami_lookup.py <ami_id> <region>
  ami_lookup.py ami-09a4a9ce71ff3f20b ap-southeast-1

"""
from docopt import docopt
import boto3


def get_ami_name(region_name, ami_id_in_region):
    ec2 = boto3.resource('ec2', region_name=region_name)
    filters = [{'Name': 'image-id', 'Values': [ami_id_in_region]}]
    images = ec2.images.filter(Filters=filters).all()
    image_name = None
    for image in images:
        image_name = image.name
    return image_name


def amis_for_region(region_name, ami_id_in_region):
    region_list = ['us-east-2', 'us-east-1', 'us-west-1', 'us-west-2', 'ap-south-1', 'ap-northeast-2', \
                   'ap-southeast-1', 'ap-southeast-2', 'ap-northeast-1', 'ca-central-1', 'eu-central-1', 'eu-west-1', \
                   'eu-west-2', 'eu-west-3', 'sa-east-1']
    mappings = {}
    image_name = get_ami_name(region_name, ami_id_in_region)
    if image_name is not None:
        for region in region_list:
            ec2 = boto3.resource('ec2', region_name=region)
            filters = [{'Name': 'name', 'Values': [image_name]}]
            images = ec2.images.filter(Filters=filters).all()
            if images is not None:
                for image in images:
                    mappings[region] = image.id
    return mappings


# Example:
# python ami_lookup.py ami-2a0f324f us-east-2
if __name__ == '__main__':
    arguments = docopt(__doc__)

    print("\n" + \
          "|--------------------------------------------------|\n" + \
          "| Generating map.  This will take several seconds. |\n" + \
          "| Please wait...                                   |\n" + \
          "|--------------------------------------------------|\n")

    mappings = amis_for_region(arguments['<region>'], arguments['<ami_id>'])
    if len(mappings) > 0:
        # Bug trailing "," for last element in map
        print('"RegionMap" : {')
        for key, value in mappings.items():
            print("\t\"{0}\"   : {{ \"AMI\" : \"{1}\"}},".format(key, value))
        print('}')


"""
Sample Output

"RegionMap" : {
	"us-east-2"   : { "AMI" : "ami-0fc20dd1da406780b"},
	"us-east-1"   : { "AMI" : "ami-07ebfd5b3428b6f4d"},
	"us-west-1"   : { "AMI" : "ami-03ba3948f6c37a4b0"},
	"us-west-2"   : { "AMI" : "ami-0d1cd67c26f5fca19"},
	"ap-south-1"   : { "AMI" : "ami-0620d12a9cf777c87"},
	"ap-northeast-2"   : { "AMI" : "ami-0cd7b0de75f5a35d1"},
	"ap-southeast-1"   : { "AMI" : "ami-09a4a9ce71ff3f20b"},
	"ap-southeast-2"   : { "AMI" : "ami-02a599eb01e3b3c5b"},
	"ap-northeast-1"   : { "AMI" : "ami-07f4cb4629342979c"},
	"ca-central-1"   : { "AMI" : "ami-098dce2d49ef14294"},
	"eu-central-1"   : { "AMI" : "ami-0b418580298265d5c"},
	"eu-west-1"   : { "AMI" : "ami-035966e8adab4aaad"},
	"eu-west-2"   : { "AMI" : "ami-006a0174c6c25ac06"},
	"eu-west-3"   : { "AMI" : "ami-096b8af6e7e8fb927"},
	"sa-east-1"   : { "AMI" : "ami-05494b93950efa2fd"},
}
"""