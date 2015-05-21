#!/bin/bash
#
#            Copyright (C) 2015 QDevor
#
#  Licensed under the GNU General Public License, Version 3.0 (the License);
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#            http://www.gnu.org/licenses/gpl-3.0.html
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# A git hook to make sure user.email and user.mail in repository exists before committing
global_email=$(git config --global user.email)
global_name=$(git config --global user.name)
repository_email=$(git config user.email)
repository_name=$(git config user.name)
if [ -z "$repository_email" ] || [ -z "$repository_name" ] || [ -n "$global_email" ] || [ -n "$global_name" ]; then
	# user.email is empty
	echo "ERROR: [pre-commit hook] Aborting commit because user.email or user.name is missing. Configure them for this repository. Make sure not to configure globally."
	exit 1
else
	# user.email is not empty
	exit 0
fi
