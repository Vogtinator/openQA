# Copyright (C) 2015 SUSE Linux Products GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, see <http://www.gnu.org/licenses/>.

package OpenQA::Schema::Result::JobGroups;
use base qw/DBIx::Class::Core/;
use strict;

__PACKAGE__->table('job_groups');
__PACKAGE__->load_components(qw/Timestamps/);

__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1,
    },
    name => {
        data_type   => 'text',
        is_nullable => 0,
    },
    size_limit_gb => {
        data_type     => 'integer',
        default_value => 100,
    },
    keep_logs_in_days => {
        data_type     => 'integer',
        default_value => 30,
    });

__PACKAGE__->add_unique_constraint([qw/name/]);

__PACKAGE__->add_timestamps;
__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_many(jobs => 'OpenQA::Schema::Result::Jobs', 'group_id');
__PACKAGE__->has_many(comments => 'OpenQA::Schema::Result::Comments', 'group_id', {order_by => 'id'});

1;
